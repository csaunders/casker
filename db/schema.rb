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

ActiveRecord::Schema.define(version: 20150819210659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.integer  "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beer_styles", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "beers", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "details"
    t.string   "details_html"
    t.decimal  "abv",           null: false
    t.decimal  "ibu",           null: false
    t.decimal  "srm"
    t.decimal  "fg"
    t.integer  "brewery_id",    null: false
    t.integer  "beer_style_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "beers", ["beer_style_id"], name: "index_beers_on_beer_style_id", using: :btree
  add_index "beers", ["brewery_id"], name: "index_beers_on_brewery_id", using: :btree

  create_table "breweries", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "tagline"
    t.string   "website",     null: false
    t.integer  "location_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "breweries", ["location_id"], name: "index_breweries_on_location_id", using: :btree

  create_table "casks", force: :cascade do |t|
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

  create_table "drinks", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "cask_id"
    t.boolean  "done"
    t.boolean  "favourite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drinks", ["attendee_id", "done"], name: "index_drinks_on_attendee_id_and_done", using: :btree
  add_index "drinks", ["attendee_id", "favourite"], name: "index_drinks_on_attendee_id_and_favourite", using: :btree

  create_table "festival_entries", force: :cascade do |t|
    t.integer  "festival_id",         null: false
    t.integer  "beer_id",             null: false
    t.integer  "festival_identifier", null: false
    t.text     "metadata"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "festival_entries", ["festival_id"], name: "index_festival_entries_on_festival_id", using: :btree

  create_table "festivals", force: :cascade do |t|
    t.string   "name",             null: false
    t.text     "description"
    t.text     "description_html"
    t.datetime "starts_at",        null: false
    t.datetime "ends_at",          null: false
    t.string   "website",          null: false
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "address",          null: false
    t.integer  "location_id",      null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "festivals", ["location_id"], name: "index_festivals_on_location_id", using: :btree
  add_index "festivals", ["starts_at"], name: "index_festivals_on_starts_at", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.string   "country",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["city"], name: "index_locations_on_city", using: :btree
  add_index "locations", ["country"], name: "index_locations_on_country", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "roles", ["user_id", "name"], name: "index_roles_on_user_id_and_name", unique: true, using: :btree

  create_table "tasting_notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.string   "authenticated_by", null: false
    t.string   "password_digest",  null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["authenticated_by"], name: "index_users_on_authenticated_by", using: :btree
  add_index "users", ["identifier"], name: "index_users_on_identifier", using: :btree

  create_table "wishlist_entries", force: :cascade do |t|
    t.integer  "beer_id",                     null: false
    t.integer  "wishlist_id",                 null: false
    t.boolean  "done",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "wishlist_entries", ["wishlist_id"], name: "index_wishlist_entries_on_wishlist_id", using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "user_id",     null: false
    t.integer  "festival_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "wishlists", ["user_id"], name: "index_wishlists_on_user_id", using: :btree

  add_foreign_key "festival_entries", "festivals", on_delete: :cascade
  add_foreign_key "roles", "users", on_delete: :cascade
  add_foreign_key "wishlist_entries", "wishlists", on_delete: :cascade
end
