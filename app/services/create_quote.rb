# frozen_string_literal: true

# Creates a quote from an EVEPraisal.
class CreateQuote
  attr_reader :quote

  def initialize(params = {})
    @quote = Quote.new(params)
  end

  def call
    return quote unless quote.valid?

    evepraisal = fetch_evepraisal(quote.evepraisal_url)
    return quote unless evepraisal

    quote.evepraisal_data = evepraisal
    quote.evepraisal_id = evepraisal['id']
    quote.save
    quote
  end

  private

  def fetch_evepraisal(url)
    response = Faraday.get("#{url}.json", {}, { 'User-Agent': Redimo::Application::USER_AGENT })
    return if response.status != 200

    JSON.parse(response.body)
  end
end
