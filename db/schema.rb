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

ActiveRecord::Schema.define(version: 0) do

  create_table "diagnostics", force: :cascade do |t|
    t.integer  "target_id",     limit: 4,    null: false
    t.boolean  "resolved",                   null: false
    t.float    "resolved_at",   limit: 24,   null: false
    t.boolean  "connected",                  null: false
    t.float    "connected_at",  limit: 24,   null: false
    t.float    "total_time",    limit: 24,   null: false
    t.integer  "status",        limit: 4,    null: false
    t.float    "size",          limit: 24,   null: false
    t.string   "error_details", limit: 5000
    t.datetime "created_at",                 null: false
  end

  create_table "targets", force: :cascade do |t|
    t.string   "life_url",   limit: 255, default: "", null: false
    t.integer  "timeout",    limit: 4,                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
