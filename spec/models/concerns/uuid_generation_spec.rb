# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UUIDGeneration do
  let(:model_class) do
    Class.new(ApplicationRecord) do
      self.table_name = 'users'

      include UUIDGeneration
    end
  end

  it 'generates a UUID before validation on creation' do
    record = model_class.new
    record.validate
    expect(record.uuid.length).to eq(36)
  end
end
