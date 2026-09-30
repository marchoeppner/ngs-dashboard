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

ActiveRecord::Schema[8.1].define(version: 2026_09_30_075354) do
  create_table "job_schedulers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.string "submission_rule"
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "attempts"
    t.string "command"
    t.boolean "completed"
    t.date "completed_at"
    t.datetime "created_at", null: false
    t.integer "depends_on"
    t.integer "job_id"
    t.string "log"
    t.integer "pipeline_id", null: false
    t.integer "run_id", null: false
    t.string "run_path"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["pipeline_id"], name: "index_jobs_on_pipeline_id"
    t.index ["run_id"], name: "index_jobs_on_run_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "R1"
    t.string "R2"
    t.string "accession"
    t.datetime "created_at", null: false
    t.integer "lane"
    t.string "name"
    t.integer "platform_id", null: false
    t.float "q30"
    t.integer "read_count"
    t.string "read_length"
    t.integer "run_id", null: false
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_libraries_on_platform_id"
    t.index ["run_id"], name: "index_libraries_on_run_id"
  end

  create_table "pipelines", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "job_level"
    t.string "name"
    t.boolean "run_level"
    t.text "samplesheet_format"
    t.string "template"
    t.datetime "updated_at", null: false
    t.float "version"
  end

  create_table "platforms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.text "comments"
    t.datetime "created_at", null: false
    t.boolean "demuxed"
    t.string "location"
    t.string "name"
    t.integer "platform_id", null: false
    t.date "run_date"
    t.datetime "updated_at", null: false
    t.index ["platform_id"], name: "index_runs_on_platform_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "xref_job_libraries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "job_id", null: false
    t.integer "library_id", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_xref_job_libraries_on_job_id"
    t.index ["library_id"], name: "index_xref_job_libraries_on_library_id"
  end

  add_foreign_key "jobs", "pipelines"
  add_foreign_key "jobs", "runs"
  add_foreign_key "jobs", "users"
  add_foreign_key "libraries", "platforms"
  add_foreign_key "libraries", "runs"
  add_foreign_key "projects", "users"
  add_foreign_key "runs", "platforms"
  add_foreign_key "sessions", "users"
  add_foreign_key "xref_job_libraries", "jobs"
  add_foreign_key "xref_job_libraries", "libraries"
end
