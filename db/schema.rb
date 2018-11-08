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

ActiveRecord::Schema.define(version: 2018_09_13_005450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.integer "org_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues_players", id: false, force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "player_id", null: false
    t.index ["league_id", "player_id"], name: "index_leagues_players_on_league_id_and_player_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "played_at", null: false
    t.integer "player1_id", null: false
    t.integer "player2_id", null: false
    t.integer "player3_id", null: false
    t.integer "player4_id", null: false
    t.decimal "player1_rating_start", precision: 15, scale: 2, null: false
    t.decimal "player2_rating_start", precision: 15, scale: 2, null: false
    t.decimal "player3_rating_start", precision: 15, scale: 2, null: false
    t.decimal "player4_rating_start", precision: 15, scale: 2, null: false
    t.decimal "player1_rating_end", precision: 15, scale: 2, null: false
    t.decimal "player2_rating_end", precision: 15, scale: 2, null: false
    t.decimal "player3_rating_end", precision: 15, scale: 2, null: false
    t.decimal "player4_rating_end", precision: 15, scale: 2, null: false
    t.integer "team1_set1_games", limit: 2, default: 0, null: false
    t.integer "team1_set2_games", limit: 2, default: 0, null: false
    t.integer "team1_set3_games", limit: 2, default: 0, null: false
    t.integer "team2_set1_games", limit: 2, default: 0, null: false
    t.integer "team2_set2_games", limit: 2, default: 0, null: false
    t.integer "team2_set3_games", limit: 2, default: 0, null: false
    t.integer "k_value", limit: 2, null: false
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "team1_rating_change", precision: 15, scale: 2, null: false
    t.decimal "team2_rating_change", precision: 15, scale: 2, null: false
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.decimal "rating", precision: 15, scale: 2
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
