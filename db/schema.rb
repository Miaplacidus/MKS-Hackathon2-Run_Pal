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

ActiveRecord::Schema.define(version: 20140522110856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: true do |t|
    t.string   "name"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  add_index "challenges", ["post_id"], name: "index_challenges_on_post_id", using: :btree
  add_index "challenges", ["recipient_id"], name: "index_challenges_on_recipient_id", using: :btree
  add_index "challenges", ["sender_id"], name: "index_challenges_on_sender_id", using: :btree

  create_table "circle_users", force: true do |t|
    t.integer  "circle_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circles", force: true do |t|
    t.string   "name"
    t.integer  "max_members"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
    t.text     "description"
    t.integer  "level"
  end

  add_index "circles", ["admin_id"], name: "index_circles_on_admin_id", using: :btree

  create_table "commitments", force: true do |t|
    t.float   "amount"
    t.boolean "fulfilled", default: false
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "commitments", ["post_id"], name: "index_commitments_on_post_id", using: :btree
  add_index "commitments", ["user_id"], name: "index_commitments_on_user_id", using: :btree

  create_table "post_users", force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "post_users", ["post_id"], name: "index_post_users_on_post_id", using: :btree
  add_index "post_users", ["user_id"], name: "index_post_users_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "circle_id"
    t.datetime "time"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "pace"
    t.text     "notes"
    t.boolean  "complete"
    t.float    "min_amt"
    t.integer  "age_pref"
    t.integer  "gender_pref"
    t.integer  "max_runners"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "posts", ["circle_id"], name: "index_posts_on_circle_id", using: :btree
  add_index "posts", ["creator_id"], name: "index_posts_on_creator_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.integer  "gender"
    t.string   "email"
    t.string   "bday"
    t.float    "rating"
    t.string   "fbid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "img"
    t.integer  "level"
  end

  create_table "wallets", force: true do |t|
    t.integer "user_id"
    t.float   "balance"
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", using: :btree

end
