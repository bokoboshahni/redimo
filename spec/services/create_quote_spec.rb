# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateQuote, type: :service do
  subject(:create_quote) { described_class.new(quote_params) }

  describe 'with EVEPraisal URL' do
    context 'with valid EVEPraisal URL', :vcr do
      let(:quote_params) { { evepraisal_url: 'https://evepraisal.com/a/yqfdq' } }
      let(:data) { JSON.parse(File.read(Rails.root.join('spec/fixtures/evepraisal/yqfdq.json'))) }
      let(:quote) { create_quote.call }

      it 'creates the quote' do
        expect(quote).to be_persisted
      end

      it 'updates the quote with the appraisal data' do
        quote = create_quote.call
        expect(quote.evepraisal_data).to include(data)
      end

      it 'updates the quote with the appraisal ID' do
        quote = create_quote.call
        expect(quote.evepraisal_id).to eq('yqfdq')
      end
    end

    context 'with invalid EVEPraisal URL', :vcr do
      let(:quote_params) { { evepraisal_url: 'https://evepraisal.com/a/nonexistent' } }

      it 'does not create the quote' do
        expect(create_quote.call).not_to be_persisted
      end
    end

    context 'with non-EVEPraisal URL' do
      let(:quote_params) { { evepraisal_url: 'https://not-evepraisal.com/a/bcdefg' } }

      it 'does not create the quote' do
        expect(create_quote.call).not_to be_persisted
      end
    end

    context 'with invalid URL' do
      let(:quote_params) { { evepraisal_url: 'http:www.example.com/main.html' } }

      it 'does not create the quote' do
        expect(create_quote.call).not_to be_persisted
      end
    end
  end
end
