# frozen_string_literal: true

# Migration to create the quotes table.
class CreateQuotes < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :quotes, id: :text do |t|
      t.text :evepraisal_id
      t.jsonb :evepraisal_data
      t.datetime :expires_at
      t.serial :number, null: false
      t.decimal :price
      t.uuid :uuid, null: false
      t.timestamps null: false

      t.index :number, unique: true
      t.index :evepraisal_data, using: :gin
      t.index :evepraisal_id, unique: true
      t.index :expires_at
      t.index :uuid, unique: true
    end
  end
end
