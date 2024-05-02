# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_05_02_142055) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "algae_heights", force: :cascade do |t|
    t.bigint "manager_id"
    t.bigint "site_id"
    t.bigint "user_id"
    t.date "date_completed"
    t.integer "rep"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "proofed", default: false
    t.index ["manager_id"], name: "index_algae_heights_on_manager_id"
    t.index ["site_id"], name: "index_algae_heights_on_site_id"
    t.index ["user_id"], name: "index_algae_heights_on_user_id"
  end

  create_table "algaes", force: :cascade do |t|
    t.string "code_name"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "occurrence"
  end

  create_table "boatlog_surveys", force: :cascade do |t|
    t.bigint "boatlog_id"
    t.bigint "user_id"
    t.bigint "survey_type_id"
    t.integer "rep"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["boatlog_id"], name: "index_boatlog_surveys_on_boatlog_id"
    t.index ["survey_type_id"], name: "index_boatlog_surveys_on_survey_type_id"
    t.index ["user_id"], name: "index_boatlog_surveys_on_user_id"
  end

  create_table "boatlogs", force: :cascade do |t|
    t.date "date_completed"
    t.time "begin_time"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "manager_id"
    t.bigint "site_id"
    t.text "notes"
    t.index ["manager_id"], name: "index_boatlogs_on_manager_id"
    t.index ["site_id"], name: "index_boatlogs_on_site_id"
  end

  create_table "coral_codes", force: :cascade do |t|
    t.string "code_name"
    t.string "group"
    t.string "category"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "occurrence"
    t.string "long_code"
    t.decimal "max_diam", precision: 4, scale: 1
    t.decimal "max_height", precision: 4, scale: 1
    t.string "ecmp_target"
  end

  create_table "coral_healths", force: :cascade do |t|
    t.bigint "manager_id"
    t.bigint "site_id"
    t.bigint "user_id"
    t.date "date_completed"
    t.integer "rep"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "method"
    t.boolean "proofed", default: false
    t.index ["manager_id"], name: "index_coral_healths_on_manager_id"
    t.index ["site_id"], name: "index_coral_healths_on_site_id"
    t.index ["user_id"], name: "index_coral_healths_on_user_id"
  end

  create_table "coral_interactions", force: :cascade do |t|
    t.bigint "transect_coral_id"
    t.bigint "coral_code_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coral_code_id"], name: "index_coral_interactions_on_coral_code_id"
    t.index ["transect_coral_id"], name: "index_coral_interactions_on_transect_coral_id"
  end

  create_table "diademas", force: :cascade do |t|
    t.bigint "fish_transect_id"
    t.integer "test_size_cm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_transect_id"], name: "index_diademas_on_fish_transect_id"
  end

  create_table "e_boatlog_teams", force: :cascade do |t|
    t.bigint "e_boatlog_id"
    t.integer "team"
    t.bigint "user_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_boatlog_id"], name: "index_e_boatlog_teams_on_e_boatlog_id"
    t.index ["user_id"], name: "index_e_boatlog_teams_on_user_id"
  end

  create_table "e_boatlogs", force: :cascade do |t|
    t.integer "fid"
    t.date "date_completed"
    t.string "captain"
    t.integer "dod"
    t.decimal "latitude", precision: 7, scale: 5
    t.decimal "longitude", precision: 7, scale: 5
    t.time "time_in"
    t.time "time_out"
    t.integer "depth_ft"
    t.string "hss"
    t.string "disease"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "e_esa_pas", force: :cascade do |t|
    t.bigint "e_survey_id"
    t.string "oann"
    t.string "ofav"
    t.string "ofra"
    t.string "apal"
    t.string "acer"
    t.string "dcyl"
    t.string "mfer"
    t.string "mmea"
    t.string "dsto"
    t.string "efas"
    t.string "dead_APAL"
    t.string "dead_DCYL"
    t.string "rami"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_survey_id"], name: "index_e_esa_pas_on_e_survey_id"
  end

  create_table "e_plot_corals", force: :cascade do |t|
    t.bigint "e_plot_id"
    t.integer "quadrant"
    t.bigint "coral_code_id"
    t.decimal "max_diam", precision: 4, scale: 1
    t.integer "old_mortality"
    t.integer "new_mortality"
    t.string "disease"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coral_code_id"], name: "index_e_plot_corals_on_coral_code_id"
    t.index ["e_plot_id"], name: "index_e_plot_corals_on_e_plot_id"
  end

  create_table "e_plots", force: :cascade do |t|
    t.bigint "e_survey_id"
    t.string "plot"
    t.string "habitat"
    t.integer "hardbottom"
    t.integer "min_depth"
    t.integer "max_depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_relief_cm"
    t.index ["e_survey_id"], name: "index_e_plots_on_e_survey_id"
  end

  create_table "e_surveys", force: :cascade do |t|
    t.integer "fid"
    t.bigint "user_id"
    t.integer "team"
    t.string "role"
    t.date "date_completed"
    t.time "begin_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["user_id"], name: "index_e_surveys_on_user_id"
  end

  create_table "fish", force: :cascade do |t|
    t.string "common_name"
    t.string "scientific_name"
    t.string "code_name"
    t.string "family"
    t.string "troph"
    t.string "commercial"
    t.integer "min_size"
    t.integer "max_size"
    t.integer "max_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "occurrence"
  end

  create_table "fish_rovers", force: :cascade do |t|
    t.bigint "manager_id"
    t.bigint "site_id"
    t.bigint "user_id"
    t.date "date_completed"
    t.time "begin_time"
    t.string "oc_cc"
    t.integer "rep"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "proofed", default: false
    t.index ["manager_id"], name: "index_fish_rovers_on_manager_id"
    t.index ["site_id"], name: "index_fish_rovers_on_site_id"
    t.index ["user_id"], name: "index_fish_rovers_on_user_id"
  end

  create_table "fish_transects", force: :cascade do |t|
    t.bigint "manager_id"
    t.bigint "site_id"
    t.bigint "user_id"
    t.date "date_completed"
    t.time "begin_time"
    t.integer "rep"
    t.integer "completed_m"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "oc_cc"
    t.boolean "proofed", default: false
    t.index ["manager_id"], name: "index_fish_transects_on_manager_id"
    t.index ["site_id"], name: "index_fish_transects_on_site_id"
    t.index ["user_id"], name: "index_fish_transects_on_user_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "project"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_managers_on_user_id"
  end

  create_table "rover_fishes", force: :cascade do |t|
    t.bigint "fish_rover_id"
    t.bigint "fish_id"
    t.integer "abundance_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_rover_fishes_on_fish_id"
    t.index ["fish_rover_id"], name: "index_rover_fishes_on_fish_rover_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "site_name"
    t.string "site_code"
    t.string "island"
    t.float "latitude"
    t.float "longitude"
    t.string "orientation"
    t.string "land"
    t.string "reef_complex"
    t.integer "depth_m"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "survey_types", force: :cascade do |t|
    t.string "type_name"
    t.string "category"
    t.string "units"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "transect_algaes", force: :cascade do |t|
    t.bigint "algae_height_id"
    t.bigint "algae_id"
    t.decimal "height_cm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["algae_height_id"], name: "index_transect_algaes_on_algae_height_id"
    t.index ["algae_id"], name: "index_transect_algaes_on_algae_id"
  end

  create_table "transect_corals", force: :cascade do |t|
    t.bigint "coral_health_id"
    t.bigint "coral_code_id"
    t.decimal "length_cm", precision: 4, scale: 1
    t.decimal "width_cm", precision: 4, scale: 1
    t.decimal "height_cm", precision: 4, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "old_mortality"
    t.integer "new_mortality"
    t.text "notes"
    t.integer "bl_sp"
    t.integer "bl_p"
    t.integer "bl_vp"
    t.integer "bl_bl"
    t.integer "disease"
    t.index ["coral_code_id"], name: "index_transect_corals_on_coral_code_id"
    t.index ["coral_health_id"], name: "index_transect_corals_on_coral_health_id"
  end

  create_table "transect_fishes", force: :cascade do |t|
    t.bigint "fish_transect_id"
    t.bigint "fish_id"
    t.integer "x0to5"
    t.integer "x6to10"
    t.integer "x11to20"
    t.integer "x21to30"
    t.integer "x31to40"
    t.integer "x41to50"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "x51to60"
    t.integer "x61to70"
    t.integer "x71to80"
    t.integer "x81to90"
    t.integer "x91to100"
    t.integer "x101to110"
    t.integer "x111to120"
    t.integer "x121to130"
    t.integer "x131to140"
    t.integer "x141to150"
    t.integer "xgt150"
    t.index ["fish_id"], name: "index_transect_fishes_on_fish_id"
    t.index ["fish_transect_id"], name: "index_transect_fishes_on_fish_transect_id"
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
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "algae_heights", "managers"
  add_foreign_key "algae_heights", "sites"
  add_foreign_key "algae_heights", "users"
  add_foreign_key "boatlog_surveys", "boatlogs"
  add_foreign_key "boatlog_surveys", "survey_types"
  add_foreign_key "boatlog_surveys", "users"
  add_foreign_key "boatlogs", "managers"
  add_foreign_key "boatlogs", "sites"
  add_foreign_key "coral_healths", "managers"
  add_foreign_key "coral_healths", "sites"
  add_foreign_key "coral_healths", "users"
  add_foreign_key "coral_interactions", "coral_codes"
  add_foreign_key "coral_interactions", "transect_corals"
  add_foreign_key "diademas", "fish_transects"
  add_foreign_key "e_boatlog_teams", "e_boatlogs"
  add_foreign_key "e_boatlog_teams", "users"
  add_foreign_key "e_esa_pas", "e_surveys"
  add_foreign_key "e_plot_corals", "coral_codes"
  add_foreign_key "e_plot_corals", "e_plots"
  add_foreign_key "e_plots", "e_surveys"
  add_foreign_key "e_surveys", "users"
  add_foreign_key "fish_rovers", "managers"
  add_foreign_key "fish_rovers", "sites"
  add_foreign_key "fish_rovers", "users"
  add_foreign_key "fish_transects", "managers"
  add_foreign_key "fish_transects", "sites"
  add_foreign_key "fish_transects", "users"
  add_foreign_key "managers", "users"
  add_foreign_key "rover_fishes", "fish"
  add_foreign_key "rover_fishes", "fish_rovers"
  add_foreign_key "transect_algaes", "algae_heights"
  add_foreign_key "transect_algaes", "algaes"
  add_foreign_key "transect_corals", "coral_codes"
  add_foreign_key "transect_corals", "coral_healths"
  add_foreign_key "transect_fishes", "fish"
  add_foreign_key "transect_fishes", "fish_transects"
end
