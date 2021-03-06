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

ActiveRecord::Schema.define(version: 20160314031551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "price"
    t.boolean  "deal",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "bids", ["event_id"], name: "index_bids_on_event_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.date     "date"
    t.time     "starting_time"
    t.time     "ending_time"
    t.string   "pax"
    t.string   "variety"
    t.string   "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "closed",        default: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "block"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "postal_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "locations", ["event_id"], name: "index_locations_on_event_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "bid_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["bid_id"], name: "index_messages_on_bid_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "nationality"
    t.string   "image"
    t.boolean  "chef_status",            default: false
    t.string   "about_chef"
    t.string   "speciality"
    t.string   "chef_ic"
    t.string   "chef_experience"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id"
    t.integer  "voted_id"
    t.integer  "cast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["voted_id"], name: "index_votes_on_voted_id", using: :btree
  add_index "votes", ["voter_id", "voted_id"], name: "index_votes_on_voter_id_and_voted_id", unique: true, using: :btree
  add_index "votes", ["voter_id"], name: "index_votes_on_voter_id", using: :btree

  add_foreign_key "bids", "events"
  add_foreign_key "bids", "users"
  add_foreign_key "locations", "events"
  add_foreign_key "messages", "bids"
  add_foreign_key "messages", "users"
end
