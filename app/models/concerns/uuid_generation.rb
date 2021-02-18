# frozen_string_literal: true

# Generates UUIDs.
module UUIDGeneration
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uuid, on: :create
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
