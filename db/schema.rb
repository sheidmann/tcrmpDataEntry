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

ActiveRecord::Schema.define(version: 2020_05_19_193529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boatlog_surveys", force: :cascade do |t|
    t.bigint "boatlog_id"
    t.bigint "user_id"
    t.bigint "survey_type_id"
    t.integer "rep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boatlog_id"], name: "index_boatlog_surveys_on_boatlog_id"
    t.index ["survey_type_id"], name: "index_boatlog_surveys_on_survey_type_id"
    t.index ["user_id"], name: "index_boatlog_surveys_on_user_id"
  end

  create_table "boatlogs", force: :cascade do |t|
    t.string "site"
    t.date "date_completed"
    t.time "begin_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manager_id"
    t.index ["manager_id"], name: "index_boatlogs_on_manager_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "project"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_managers_on_user_id"
  end

  create_table "survey_types", force: :cascade do |t|
    t.string "type_name"
    t.string "category"
    t.string "units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "agency"
    t.string "active"
    t.string "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "boatlog_surveys", "boatlogs"
  add_foreign_key "boatlog_surveys", "survey_types"
  add_foreign_key "boatlog_surveys", "users"
  add_foreign_key "boatlogs", "managers"
  add_foreign_key "managers", "users"
end
