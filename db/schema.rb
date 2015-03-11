# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150311191020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "user_cities", force: :cascade do |t|
    t.integer "user_id"
    t.integer "city_id"
  end

  add_index "user_cities", ["city_id"], name: "index_user_cities_on_city_id", using: :btree
  add_index "user_cities", ["user_id"], name: "index_user_cities_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "provider"
    t.string   "token"
    t.string   "uid"
    t.string   "image_url"
    t.string   "promo_code"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "phone_number"
    t.string   "vehicle_photo_file_name"
    t.string   "vehicle_photo_content_type"
    t.integer  "vehicle_photo_file_size"
    t.datetime "vehicle_photo_updated_at"
    t.datetime "uber_start_date"
    t.integer  "avg_weekly_rides"
  end

  add_foreign_key "user_cities", "cities"
  add_foreign_key "user_cities", "users"
end
