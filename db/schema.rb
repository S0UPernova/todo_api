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

ActiveRecord::Schema.define(version: 2022_02_11_035747) do

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "requirements"
    t.integer "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id", "created_at"], name: "index_projects_on_team_id_and_created_at"
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "completed", default: false
    t.datetime "duedate"
    t.datetime "completed_at"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "team_requests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.boolean "from_team"
    t.boolean "accepted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_requests_on_team_id"
    t.index ["user_id", "team_id"], name: "index_team_requests_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_team_requests_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_teams_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "teams_relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_teams_relationships_on_team_id"
    t.index ["user_id", "team_id"], name: "index_teams_relationships_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_teams_relationships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "projects", "teams"
  add_foreign_key "tasks", "projects"
  add_foreign_key "teams", "users"
end
