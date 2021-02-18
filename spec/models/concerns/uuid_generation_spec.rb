# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UUIDGeneration do
  it 'generates a UUID before validation on creation' do
    record = FactoryBot.build(:quote)
    record.validate
    expect(record.uuid.length).to eq(36)
  end
end
