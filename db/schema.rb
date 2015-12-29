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

ActiveRecord::Schema.define(version: 20151224015223) do

  create_table "bus_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "capacity",          default: 50
    t.text     "notes"
    t.boolean  "needs_bus_captain", default: false
  end

  create_table "fips", force: true do |t|
    t.string   "fips_code"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "recipients"
    t.text     "body"
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template",     default: "default"
  end

  create_table "questionnaires", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "year"
    t.date     "birthday"
    t.string   "experience"
    t.string   "interest"
    t.string   "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shirt_size"
    t.string   "dietary_medical_notes"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.boolean  "international"
    t.string   "portfolio_url"
    t.string   "vcs_url"
    t.integer  "user_id"
    t.boolean  "agreement_accepted",    default: false
    t.string   "acc_status",            default: "pending"
    t.integer  "acc_status_author_id"
    t.datetime "acc_status_date"
    t.boolean  "riding_bus",            default: false
    t.boolean  "bus_captain_interest",  default: false
    t.boolean  "is_bus_captain",        default: false
    t.integer  "checked_in_by_id"
    t.datetime "checked_in_at"
    t.string   "phone"
    t.boolean  "can_share_resume",      default: false
  end

  add_index "questionnaires", ["user_id"], name: "index_questionnaires_on_user_id"

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "questionnaire_count"
    t.integer  "bus_list_id"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.boolean  "admin_limited_access",   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
