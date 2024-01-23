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

ActiveRecord::Schema[7.0].define(version: 2024_01_21_121316) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "ip_address_id", null: false
    t.index ["ip_address_id"], name: "index_domains_on_ip_address_id"
    t.index ["name"], name: "index_domains_on_name", unique: true
  end

  create_table "geolocations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.uuid "ip_address_id", null: false
    t.index ["city"], name: "index_geolocations_on_city"
    t.index ["continent_code"], name: "index_geolocations_on_continent_code"
    t.index ["continent_name"], name: "index_geolocations_on_continent_name"
    t.index ["country_code"], name: "index_geolocations_on_country_code"
    t.index ["country_name"], name: "index_geolocations_on_country_name"
    t.index ["ip_address_id"], name: "index_geolocations_on_ip_address_id"
    t.index ["latitude"], name: "index_geolocations_on_latitude"
    t.index ["longitude"], name: "index_geolocations_on_longitude"
    t.index ["region_code"], name: "index_geolocations_on_region_code"
    t.index ["region_name"], name: "index_geolocations_on_region_name"
    t.index ["zip"], name: "index_geolocations_on_zip"
  end

  create_table "ip_addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_ip_addresses_on_address", unique: true
  end

  add_foreign_key "domains", "ip_addresses"
  add_foreign_key "geolocations", "ip_addresses"
end
