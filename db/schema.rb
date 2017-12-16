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

ActiveRecord::Schema.define(version: 20171215104530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "code",       limit: 10
    t.string   "name",       limit: 100
    t.boolean  "active",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markers", force: :cascade do |t|
    t.string   "name",       limit: 100,                                         null: false
    t.string   "address",    limit: 100,                                         null: false
    t.decimal  "latitude",               precision: 10, scale: 6,                null: false
    t.decimal  "longitude",              precision: 10, scale: 6,                null: false
    t.boolean  "active",                                          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string  "name"
    t.string  "unique_key"
    t.integer "display_rank", default: 5, null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr", null: false
  end

  create_table "user_location_mappings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_role_mappings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 100, default: "",    null: false
    t.string   "username",        limit: 100
    t.string   "password_digest", limit: 100
    t.string   "firstname",       limit: 100
    t.string   "middleinit",      limit: 100
    t.string   "lastname",        limit: 100
    t.string   "address1",        limit: 100
    t.string   "address2",        limit: 100
    t.string   "city",            limit: 100
    t.integer  "state_id"
    t.string   "zipcode",         limit: 5
    t.boolean  "active",                      default: false, null: false
    t.string   "uuid",            limit: 100,                 null: false
    t.datetime "validated_at"
    t.integer  "sign_in_count",               default: 0,     null: false
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
