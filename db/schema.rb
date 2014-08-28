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

ActiveRecord::Schema.define(version: 20140824190809) do

  create_table "content_types", force: true do |t|
    t.string "name", null: false
  end

  create_table "scraps", force: true do |t|
    t.string   "http_method",        default: "GET",              null: false
    t.string   "endpoint",                                        null: false
    t.integer  "status_code",        default: 200,                null: false
    t.string   "content_type",       default: "application/json", null: false
    t.text     "body",                                            null: false
    t.boolean  "private",            default: false,              null: false
    t.string   "character_encoding", default: "UTF-8",            null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  create_table "status_codes", force: true do |t|
    t.integer "number",                   null: false
    t.string  "desc",                     null: false
    t.boolean "standard", default: false, null: false
    t.string  "rfc"
  end

  create_table "users", force: true do |t|
    t.datetime "remember_created_at"
    t.string   "provider",            null: false
    t.string   "uid",                 null: false
    t.string   "username",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
