# frozen_string_literal: true

# Returns normalized appraisal data from EVEPraisal or Janice.
class GetAppraisal # rubocop:disable Metrics/ClassLength
  class InvalidAppraisalURL < RuntimeError; end

  class AppraisalNotFound < RuntimeError; end

  attr_reader :url

  def initialize(url)
    @url = url.strip
    @types = {}
  end

  def call
    raise InvalidAppraisalURL unless Quote::APPRAISAL_URL_FORMAT.match?(url)

    appraisal_data = fetch_appraisal(url)
    normalize_appraisal(appraisal_data)
  end

  private

  APPRAISAL_HEADERS = { 'User-Agent': Rails.application.config.x.hos.user_agent }.freeze

  attr_reader :types

  def fetch_appraisal(url) # rubocop:disable Metrics/MethodLength
    appraisal_uri = URI.parse(url)
    case appraisal_uri.host
    when 'evepraisal.com'
      response = appraisal_connection.get("#{url}.json", APPRAISAL_HEADERS)
      type = 'evepraisal'
    when 'janice.e-351.com'
      appraisal_id = appraisal_uri.path.delete_prefix('/a/')
      type = 'janice'
      response = appraisal_connection.get("https://janice.e-351.com/api/rest/v1/appraisal/#{appraisal_id}",
                                          { key: janice_api_key }, APPRAISAL_HEADERS)
    end
    response.body.merge('type' => type)
  rescue Faraday::ResourceNotFound
    raise AppraisalNotFound
  end

  def normalize_appraisal(data)
    case data['type']
    when 'evepraisal'
      normalize_evepraisal_appraisal(data)
    when 'janice'
      normalize_janice_appraisal(data)
    end
  end

  def normalize_evepraisal_appraisal(data) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    appraisal = {
      id: data['id'],
      type: 'evepraisal',
      created_at: Time.zone.at(data['created']).to_datetime,
      market: data['market_name'],
      total_buy: data['totals']['buy'].to_f,
      total_sell: data['totals']['sell'].to_f,
      total_volume: data['totals']['volume'].to_f,
      items: data['items'].map do |item|
               {
                 buy_order_count: item['prices']['buy']['order_count'].to_i,
                 buy_price_avg: item['prices']['buy']['avg'].to_f,
                 buy_price_max: item['prices']['buy']['max'].to_f,
                 buy_price_median: item['prices']['buy']['median'].to_f,
                 buy_price_min: item['prices']['buy']['min'].to_f,
                 buy_price_std_dev: item['prices']['buy']['stddev'].to_f,
                 buy_volume: item['prices']['buy']['volume'].to_i,
                 id: item['typeID'],
                 name: item['typeName'],
                 packaged_volume: packaged_volume(item['typeID']).to_f,
                 quantity: item['quantity'].to_i,
                 sell_order_count: item['prices']['sell']['order_count'].to_i,
                 sell_price_avg: item['prices']['sell']['avg'].to_f,
                 sell_price_max: item['prices']['sell']['max'].to_f,
                 sell_price_median: item['prices']['sell']['median'].to_f,
                 sell_price_min: item['prices']['sell']['min'].to_f,
                 sell_price_std_dev: item['prices']['sell']['stddev'].to_f,
                 sell_volume: item['prices']['sell']['volume'].to_i,
                 total_packaged_volume: (packaged_volume(item['typeID']) * item['quantity']).to_f,
                 total_volume: (volume(item['typeID']) * item['quantity']).to_f,
                 volume: volume(item['typeID']).to_f
               }
             end
    }
    appraisal[:total_packaged_volume] = appraisal[:items].sum { |item| item[:total_packaged_volume] }.to_f
    appraisal[:total_volume] = appraisal[:items].sum { |item| item[:total_volume] }.to_f
    appraisal
  end

  def normalize_janice_appraisal(data) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    appraisal = {
      id: data['code'],
      type: 'janice',
      created_at: Time.zone.parse(data['created']),
      market: data['market']['name'],
      total_buy: data['totalBuyPrice'].to_f,
      total_sell: data['totalSellPrice'].to_f,
      items: data['items'].map do |item|
        {
          buy_order_count: item['buyOrderCount'].to_i,
          buy_price_avg: item['buyPriceAverage'].to_f,
          buy_price_max: item['buyPriceMax'].to_f,
          buy_price_median: item['buyPriceMedian'].to_f,
          buy_price_min: item['buyPriceMin'].to_f,
          buy_price_std_dev: item['buyPriceStdDev'].to_f,
          buy_volume: item['buyVolume'].to_i,
          id: item['itemType']['eid'],
          name: item['itemType']['name'],
          packaged_volume: item['itemType']['packagedVolume'].to_f,
          quantity: item['amount'].to_i,
          sell_order_count: item['sellOrderCount'].to_i,
          sell_price_avg: item['sellPriceAverage'].to_f,
          sell_price_max: item['sellPriceMax'].to_f,
          sell_price_median: item['sellPriceMedian'].to_f,
          sell_price_min: item['sellPriceMin'].to_f,
          sell_price_std_dev: item['sellPriceStdDev'].to_f,
          sell_volume: item['sellVolume'].to_i,
          total_packaged_volume: (item['itemType']['packagedVolume'] * item['amount']).to_f,
          total_volume: (item['itemType']['volume'] * item['amount']).to_f,
          volume: volume(item['itemType']['eid']).to_f
        }
      end
    }
    appraisal[:total_packaged_volume] = appraisal[:items].sum { |item| item[:total_packaged_volume] }
    appraisal[:total_volume] = appraisal[:items].sum { |item| item[:total_volume] }
    appraisal
  end

  def packaged_volume(id)
    (type(id).packaged_volume || type(id).volume).to_f
  end

  def volume(id)
    type(id).volume.to_f
  end

  def type(id)
    types[id] ||= EVEType.find_by!(type_id: id)
  end

  def appraisal_connection
    @appraisal_connection ||= Faraday.new do |f|
      f.use :http_cache, store: Rails.cache, logger: Rails.logger, instrumenter: ActiveSupport::Notifications
      f.request :url_encoded
      f.request :retry
      f.response :follow_redirects
      f.response :json
    end
  end

  def janice_api_key
    Rails.application.config.x.janice.api_key
  end
end
