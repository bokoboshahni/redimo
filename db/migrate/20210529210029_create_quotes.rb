# frozen_string_literal: true

# Creates the quotes table
class CreateQuotes < ActiveRecord::Migration[6.1]
  def change
    create_table :quotes, id: :text do |t|
      t.text :appraisal_id
      t.text :appraisal_url
      t.jsonb :appraisal_data
      t.text :appraisal_type
      t.datetime :expires_at
      t.serial :number, null: false
      t.jsonb :price_data
      t.text :type
      t.uuid :uuid, null: false
      t.timestamps null: false

      t.index :appraisal_data, using: :gin
      t.index :appraisal_id
      t.index :appraisal_type
      t.index :expires_at
      t.index :number, unique: true
      t.index :type
      t.index :uuid, unique: true
    end
  end
end
