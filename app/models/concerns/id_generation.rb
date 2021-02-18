# frozen_string_literal: true

# Generates IDs with Nanoid.
module IDGeneration
  extend ActiveSupport::Concern

  ID_ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHJKMNPQRSTVWXYZ'

  included do
    before_validation :generate_id, on: :create
  end

  def generate_id
    self.id = Nanoid.generate(alphabet: ID_ALPHABET)
  end
end
