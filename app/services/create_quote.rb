# frozen_string_literal: true

class CreateQuote
  attr_reader :quote

  def initialize(params = {})
    @quote = Quote.new(params)
  end

  def call
    return quote unless quote.valid?

    evepraisal = fetch_evepraisal(quote.evepraisal_url)
    return quote if evepraisal.status != 200

    quote.evepraisal_data = JSON.parse(evepraisal.body)
    quote.evepraisal_id = quote.evepraisal_data['id']
    quote.save
    quote
  end

  private

  def fetch_evepraisal(url)
    Faraday.get("#{url}.json", {}, { 'User-Agent': Redimo::Application::USER_AGENT })
  end
end
