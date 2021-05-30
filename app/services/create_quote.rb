# frozen_string_literal: true

# Creates an initial quote from an existing appraisal or list of items.
class CreateQuote
  attr_reader :appraisal_url, :quote

  def initialize(appraisal_url)
    @appraisal_url = appraisal_url
    @quote = Quote.new
  end

  def call # rubocop:disable Metrics/AbcSize
    quote.appraisal_data = GetAppraisal.new(appraisal_url).call
    quote.appraisal_id = quote.appraisal_data['id']
    quote.appraisal_type = quote.appraisal_data['type']
    quote.appraisal_url = appraisal_url
    quote.expires_at = Time.zone.now + Quote::VALID_FOR
    quote.save!
    quote
  end
end
