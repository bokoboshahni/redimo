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

ActiveRecord::Schema.define(version: 2021_05_29_164046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

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
