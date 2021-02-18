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

ActiveRecord::Schema.define(version: 2021_02_17_164330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "quotes", id: :text, force: :cascade do |t|
    t.text "evepraisal_id"
    t.jsonb "evepraisal_data"
    t.datetime "expires_at"
    t.serial "number", null: false
    t.decimal "price"
    t.uuid "uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evepraisal_data"], name: "index_quotes_on_evepraisal_data", using: :gin
    t.index ["evepraisal_id"], name: "index_quotes_on_evepraisal_id", unique: true
    t.index ["expires_at"], name: "index_quotes_on_expires_at"
    t.index ["number"], name: "index_quotes_on_number", unique: true
    t.index ["uuid"], name: "index_quotes_on_uuid", unique: true
  end

end
