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
# It"s strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_240_121_121_316) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domain_names", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "internet_protocol_id", null: false
    t.index ["internet_protocol_id"], name: "index_domain_names_on_internet_protocol_id"
    t.index ["name"], name: "index_domain_names_on_name", unique: true
  end

  create_table "geolocations", force: :cascade do |t|
    t.string "continent_code"
    t.string "continent_name"
    t.string "country_code"
    t.string "country_name"
    t.string "region_code"
    t.string "region_name"
    t.string "city"
    t.string "zip"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internet_protocols", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.index ["name"], name: "index_internet_protocols_on_name", unique: true
  end

  add_foreign_key "domain_names", "internet_protocols"
end
