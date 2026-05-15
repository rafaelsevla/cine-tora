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

ActiveRecord::Schema[8.1].define(version: 2026_05_15_013323) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.string "country_code", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.integer "duration_in_minutes", null: false
    t.string "image_url"
    t.string "name", null: false
    t.string "original_language", null: false
    t.date "release_date", null: false
    t.string "small_description"
    t.datetime "updated_at", null: false
  end

  create_table "movies_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "genre_id", null: false
    t.boolean "main_genre", default: false
    t.bigint "movie_id", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movies_genres_on_genre_id"
    t.index ["movie_id", "genre_id"], name: "index_movies_genres_on_movie_id_and_genre_id", unique: true
    t.index ["movie_id"], name: "index_movies_genres_on_movie_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "card_last_four"
    t.datetime "created_at", null: false
    t.text "gateway_response"
    t.datetime "paid_at"
    t.string "payment_method", null: false
    t.string "status", null: false
    t.bigint "ticket_id", null: false
    t.string "transaction_id", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_payments_on_ticket_id"
  end

  create_table "room_models", force: :cascade do |t|
    t.integer "columns_count", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "rows_count", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "room_model_id", null: false
    t.bigint "theater_id", null: false
    t.datetime "updated_at", null: false
    t.index ["room_model_id"], name: "index_rooms_on_room_model_id"
    t.index ["theater_id"], name: "index_rooms_on_theater_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "column", null: false
    t.datetime "created_at", null: false
    t.string "number", null: false
    t.bigint "room_id", null: false
    t.string "row", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_seats_on_room_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "showtimes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "full_price", precision: 10, scale: 2
    t.string "language", null: false
    t.bigint "movie_id", null: false
    t.bigint "room_id", null: false
    t.datetime "start_at", null: false
    t.string "subtitle"
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_showtimes_on_movie_id"
    t.index ["room_id"], name: "index_showtimes_on_room_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "address", null: false
    t.string "country_code", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "seat_id", null: false
    t.bigint "showtime_id", null: false
    t.string "status", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
    t.index ["showtime_id"], name: "index_tickets_on_showtime_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "movies_genres", "genres"
  add_foreign_key "movies_genres", "movies"
  add_foreign_key "payments", "tickets"
  add_foreign_key "rooms", "room_models"
  add_foreign_key "rooms", "theaters"
  add_foreign_key "seats", "rooms"
  add_foreign_key "sessions", "users"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "showtimes", "rooms"
  add_foreign_key "tickets", "seats"
  add_foreign_key "tickets", "showtimes"
  add_foreign_key "tickets", "users"
end
