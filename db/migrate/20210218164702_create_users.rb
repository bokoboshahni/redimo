# frozen_string_literal: true

# Migration to create the users table.
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :text do |t|
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
