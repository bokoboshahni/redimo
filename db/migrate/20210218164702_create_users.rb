# frozen_string_literal: true

# Migration to create the associates and customers tables.
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'

    create_table :users, id: :text do |t|
      t.boolean :admin, default: false
      t.boolean :associate, default: false
      t.text :esi_access_token_ciphertext
      t.datetime :esi_expires_at
      t.text :esi_refresh_token_ciphertext
      t.text :eve_character_id
      t.text :eve_character_name
      t.text :eve_character_owner_hash
      t.uuid :uuid, null: false
      t.timestamps null: false

      t.index :eve_character_id, unique: true
      t.index :eve_character_name, unique: true
      t.index :eve_character_owner_hash
      t.index :uuid, unique: true
    end
  end
end
