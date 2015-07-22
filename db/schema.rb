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

ActiveRecord::Schema.define(version: 20141024013455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: true do |t|
    t.integer  "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "casks", force: true do |t|
    t.integer  "cask",                                           null: false
    t.string   "region",                                         null: false
    t.string   "brewery",                                        null: false
    t.string   "name",                                           null: false
    t.string   "style",                                          null: false
    t.decimal  "abv",        precision: 5, scale: 2,             null: false
    t.integer  "session",                            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "casks", ["cask"], name: "index_casks_on_cask", using: :btree
  add_index "casks", ["region"], name: "index_casks_on_region", using: :btree
  add_index "casks", ["session"], name: "index_casks_on_session", using: :btree
  add_index "casks", ["style"], name: "index_casks_on_style", using: :btree

  create_table "drinks", force: true do |t|
    t.integer  "attendee_id"
    t.integer  "cask_id"
    t.boolean  "done"
    t.boolean  "favourite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drinks", ["attendee_id", "done"], name: "index_drinks_on_attendee_id_and_done", using: :btree
  add_index "drinks", ["attendee_id", "favourite"], name: "index_drinks_on_attendee_id_and_favourite", using: :btree

end
