# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_10_112602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "eve_static_data_exports", id: :text, force: :cascade do |t|
    t.text "status", null: false
    t.text "status_text"
    t.text "checksum", null: false
    t.jsonb "sde_archive_data"
    t.jsonb "sde_archive_checksum_data"
    t.jsonb "sde_archive_sha512_data"
    t.datetime "uploaded_at"
    t.uuid "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checksum"], name: "index_eve_static_data_exports_on_checksum", unique: true
    t.index ["status"], name: "index_eve_static_data_exports_on_status"
    t.index ["uuid"], name: "index_eve_static_data_exports_on_uuid", unique: true
  end

  create_table "quotes", id: :text, force: :cascade do |t|
    t.text "appraisal_id"
    t.text "appraisal_url"
    t.jsonb "appraisal_data"
    t.text "appraisal_type"
    t.datetime "expires_at"
    t.serial "number", null: false
    t.jsonb "price_data"
    t.text "type"
    t.uuid "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appraisal_data"], name: "index_quotes_on_appraisal_data", using: :gin
    t.index ["appraisal_id"], name: "index_quotes_on_appraisal_id"
    t.index ["appraisal_type"], name: "index_quotes_on_appraisal_type"
    t.index ["expires_at"], name: "index_quotes_on_expires_at"
    t.index ["number"], name: "index_quotes_on_number", unique: true
    t.index ["type"], name: "index_quotes_on_type"
    t.index ["uuid"], name: "index_quotes_on_uuid", unique: true
  end

  create_table "users", id: :text, force: :cascade do |t|
    t.boolean "admin", default: false
    t.boolean "associate", default: false
    t.text "esi_access_token_ciphertext"
    t.datetime "esi_expires_at"
    t.text "esi_refresh_token_ciphertext"
    t.text "eve_character_id"
    t.text "eve_character_name"
    t.text "eve_character_owner_hash"
    t.uuid "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "eve_alliance_id"
    t.integer "eve_corporation_id"
    t.index ["eve_alliance_id"], name: "index_users_on_eve_alliance_id"
    t.index ["eve_character_id"], name: "index_users_on_eve_character_id", unique: true
    t.index ["eve_character_name"], name: "index_users_on_eve_character_name", unique: true
    t.index ["eve_character_owner_hash"], name: "index_users_on_eve_character_owner_hash"
    t.index ["eve_corporation_id"], name: "index_users_on_eve_corporation_id"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
