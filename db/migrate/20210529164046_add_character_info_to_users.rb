# frozen_string_literal: true

# Adds additional ESI character information columns to the users table.
class AddCharacterInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, id: :text do |t|
      t.integer :eve_alliance_id
      t.integer :eve_corporation_id

      t.index :eve_alliance_id
      t.index :eve_corporation_id
    end
  end
end
