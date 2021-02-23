# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quote requests', type: :request do
  describe 'creating a quote with a valid EVEPraisal URL', :vcr do
    let(:quote_params) { { evepraisal_url: 'https://evepraisal.com/a/yqfdq' } }

    let(:new_quote) { Quote.find_by(evepraisal_id: 'yqfdq') }

    it 'redirects to the new quote' do
      post '/quotes', params: { quote: quote_params }
      expect(response).to redirect_to(quote_path(new_quote))
    end
  end

  describe 'retrieving a quote', :vcr do
    context 'when the quote exists' do
      it 'responds with success' do
        quote = CreateQuote.new(evepraisal_url: 'https://evepraisal.com/a/yqfdq').call
        get "/quotes/#{quote.id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
