# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IDGeneration do
  let(:model_class) do
    Class.new(ApplicationRecord) do
      self.table_name = 'users'

      include IDGeneration
    end
  end

  it 'generates an ID before validation on creation' do
    record = model_class.new
    record.validate
    expect(record.id.length).to eq(8)
  end
end
