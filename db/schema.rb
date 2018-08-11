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

ActiveRecord::Schema.define(version: 2018_08_11_023709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_assignments_on_project_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
  end

  create_table "rubric_categories", force: :cascade do |t|
    t.string "title"
  end

  create_table "rubrics", force: :cascade do |t|
    t.bigint "rubric_category_id"
    t.bigint "project_id"
    t.string "description"
    t.index ["project_id"], name: "index_rubrics_on_project_id"
    t.index ["rubric_category_id"], name: "index_rubrics_on_rubric_category_id"
  end

  create_table "turing_cohorts", force: :cascade do |t|
    t.string "name"
    t.string "census_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "git_hub"
    t.integer "census_id"
    t.string "image_url"
    t.integer "role"
    t.string "slack"
    t.string "twitter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "turing_cohort_id"
    t.bigint "flock_id"
    t.index ["flock_id"], name: "index_users_on_flock_id"
    t.index ["turing_cohort_id"], name: "index_users_on_turing_cohort_id"
  end

  add_foreign_key "assignments", "projects"
  add_foreign_key "assignments", "users"
  add_foreign_key "rubrics", "projects"
  add_foreign_key "rubrics", "rubric_categories"
  add_foreign_key "users", "turing_cohorts"
end
