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

ActiveRecord::Schema.define(version: 20170308062620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "monster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["monster_id"], name: "index_comments_on_monster_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "monster_name"
    t.integer  "monster_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "monsters", force: :cascade do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "hp"
    t.integer  "exp"
    t.integer  "jexp"
    t.integer  "atk1"
    t.integer  "atk2"
    t.integer  "def"
    t.integer  "mdef"
    t.integer  "str"
    t.integer  "agi"
    t.integer  "vit"
    t.integer  "int"
    t.integer  "dex"
    t.integer  "luk"
    t.integer  "scale"
    t.integer  "race"
    t.integer  "element"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "own"
    t.integer  "like",        default: 0
    t.integer  "dislike",     default: 0
    t.text     "vote_stamps"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.integer  "status_cd"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "fav_count",  default: 0
  end

end
