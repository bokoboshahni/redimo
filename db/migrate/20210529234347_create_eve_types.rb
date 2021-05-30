# frozen_string_literal: true

# Creates the eve_types table.
class CreateEVETypes < ActiveRecord::Migration[6.1]
  def change
    create_table :eve_types, id: :uuid do |t|
      t.decimal :capacity
      t.text :description
      t.jsonb :dogma_attributes
      t.jsonb :dogma_effects
      t.integer :graphic_id
      t.integer :group_id
      t.integer :icon_id
      t.integer :market_group_id
      t.decimal :mass
      t.text :name
      t.decimal :packaged_volume
      t.integer :portion_size
      t.boolean :published
      t.decimal :radius
      t.integer :type_id
      t.decimal :volume
      t.timestamps

      t.index :type_id, unique: true
    end
  end
end
