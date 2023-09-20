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

ActiveRecord::Schema[7.0].define(version: 2023_09_20_115713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "trip_event_id", null: false
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_event_id"], name: "index_addresses_on_trip_event_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paid_for_trip_events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "price_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["price_id"], name: "index_paid_for_trip_events_on_price_id"
    t.index ["user_id"], name: "index_paid_for_trip_events_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trip_id", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_participants_on_trip_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "payd_by_id"
    t.bigint "trip_event_id", null: false
    t.float "total_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_event_id"], name: "index_prices_on_trip_event_id"
  end

  create_table "trip_events", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.integer "creator_id"
    t.string "name"
    t.string "event_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_events_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "trip_events"
  add_foreign_key "paid_for_trip_events", "prices"
  add_foreign_key "paid_for_trip_events", "users"
  add_foreign_key "participants", "trips"
  add_foreign_key "participants", "users"
  add_foreign_key "prices", "trip_events"
  add_foreign_key "trip_events", "trips"
  add_foreign_key "trips", "users"
end
