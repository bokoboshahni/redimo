# frozen_string_literal: true

# Creates the eve_static_data_exports table.
class CreateEVEStaticDataExports < ActiveRecord::Migration[6.1]
  def change
    create_table :eve_static_data_exports, id: :text do |t|
      t.text :status, null: false
      t.text :status_text
      t.text :checksum, null: false
      t.jsonb :sde_archive_data
      t.jsonb :sde_archive_checksum_data
      t.jsonb :sde_archive_sha512_data
      t.datetime :uploaded_at
      t.uuid :uuid, null: false
      t.timestamps null: false

      t.index :status
      t.index :checksum, unique: true
      t.index :uuid, unique: true
    end
  end
end
