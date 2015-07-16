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

ActiveRecord::Schema.define(version: 20150716124742) do

  create_table "event_admins", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_admins", ["event_id"], name: "index_event_admins_on_event_id"
  add_index "event_admins", ["user_id"], name: "index_event_admins_on_user_id"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.text     "rules"
    t.text     "judging"
    t.datetime "event_date_time"
    t.integer  "team_size"
    t.string   "venue"
    t.string   "eligibilty"
    t.datetime "registration_deadline"
    t.text     "prizes"
    t.text     "contact"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "organizers", force: :cascade do |t|
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participant_teams", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participant_teams", ["participant_id"], name: "index_participant_teams_on_participant_id"
  add_index "participant_teams", ["team_id"], name: "index_participant_teams_on_team_id"

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "college"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id"
  add_index "registrations", ["participant_id"], name: "index_registrations_on_participant_id"

  create_table "sponsors", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "tid"
    t.string   "team_name"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["event_id"], name: "index_teams_on_event_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name"
    t.integer  "role"
    t.string   "provider"
    t.string   "uid"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
