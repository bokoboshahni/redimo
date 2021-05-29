# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetCharacter do
  subject(:service) { described_class.new(character_id) }

  let(:character_id) { '2113024536' }
  let(:result) { service.call }

  it 'returns character information from ESI', :vcr do
    expect(result).to include('alliance_id', 'corporation_id')
  end
end
