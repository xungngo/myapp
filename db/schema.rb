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

ActiveRecord::Schema.define(version: 20180514174560) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "sort"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100
    t.string "description", limit: 200
    t.string "address", limit: 200
    t.string "apt", limit: 100
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_organizations", id: :serial, force: :cascade do |t|
    t.integer "company_id"
    t.integer "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_attachment_mappings", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "attachment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventattendeetypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventdates", id: :serial, force: :cascade do |t|
    t.date "eventdate"
    t.string "starttime"
    t.string "endtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventdates_events", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "eventdate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_eventdates_events_on_event_id"
    t.index ["eventdate_id"], name: "index_eventdates_events_on_eventdate_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description", limit: 2000, null: false
    t.string "requirement", limit: 1000
    t.string "contact", limit: 100
    t.string "address", limit: 200, null: false
    t.string "price", limit: 100
    t.integer "limit"
    t.integer "eventtype_id", null: false
    t.integer "eventattendeetype_id", null: false
    t.string "tag", limit: 100
    t.integer "organization_id", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.boolean "active", default: true, null: false
    t.string "uuid", limit: 100, null: false
    t.integer "deleted_by"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "eventtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "address", limit: 100, null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.boolean "active", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200
    t.string "address", limit: 500
    t.string "apt", limit: 100
    t.string "contact", limit: 300
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.boolean "defaultorg", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "unique_key"
    t.integer "display_rank", default: 5, null: false
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr", null: false
  end

  create_table "user_role_mappings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 100, default: "", null: false
    t.string "email_temp", limit: 100
    t.datetime "email_validated_at"
    t.string "username", limit: 100
    t.string "password_digest", limit: 100
    t.string "firstname", limit: 100
    t.string "middleinit", limit: 100
    t.string "lastname", limit: 100
    t.string "address1", limit: 100
    t.string "address2", limit: 100
    t.string "city", limit: 100
    t.integer "state_id"
    t.string "zipcode", limit: 5
    t.boolean "active", default: false, null: false
    t.string "uuid", limit: 100, null: false
    t.datetime "validated_at"
    t.string "timezone"
    t.datetime "profile_updated_at"
    t.datetime "preferences_updated_at"
    t.datetime "security_updated_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_companies", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
