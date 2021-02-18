# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IDGeneration do
  it 'generates an ID before validation on creation' do
    record = FactoryBot.build(:quote)
    record.validate
    expect(record.id.length).to eq(21)
  end
end
