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

ActiveRecord::Schema.define(version: 20160208061253) do

  create_table "bus_lists", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "capacity",          limit: 4,     default: 50
    t.text     "notes",             limit: 65535
    t.boolean  "needs_bus_captain",               default: false
  end

  create_table "fips", force: :cascade do |t|
    t.string   "fips_code",  limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "subject",      limit: 255
    t.string   "recipients",   limit: 255
    t.text     "body",         limit: 65535
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "delivered_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "template",     limit: 255,   default: "default"
  end

  create_table "questionnaires", force: :cascade do |t|
    t.string   "first_name",               limit: 255
    t.string   "last_name",                limit: 255
    t.string   "email",                    limit: 255
    t.date     "date_of_birth"
    t.string   "experience",               limit: 255
    t.string   "school_id",                limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "shirt_size",               limit: 255
    t.string   "dietary_restrictions",     limit: 255
    t.string   "resume_file_name",         limit: 255
    t.string   "resume_content_type",      limit: 255
    t.integer  "resume_file_size",         limit: 4
    t.datetime "resume_updated_at"
    t.boolean  "international"
    t.string   "portfolio_url",            limit: 255
    t.string   "vcs_url",                  limit: 255
    t.integer  "user_id",                  limit: 4
    t.boolean  "agreement_accepted",                   default: false
    t.string   "acc_status",               limit: 255, default: "pending"
    t.integer  "acc_status_author_id",     limit: 4
    t.datetime "acc_status_date"
    t.boolean  "riding_bus",                           default: false
    t.boolean  "bus_captain_interest",                 default: false
    t.boolean  "is_bus_captain",                       default: false
    t.integer  "checked_in_by_id",         limit: 4
    t.datetime "checked_in_at"
    t.string   "phone",                    limit: 255
    t.boolean  "can_share_info",                       default: false
    t.boolean  "code_of_conduct_accepted",             default: false
    t.string   "special_needs",            limit: 255
    t.string   "gender",                   limit: 255
    t.date     "graduation"
    t.string   "major",                    limit: 255
    t.boolean  "travel_not_from_school",               default: false
    t.string   "travel_location",          limit: 255
  end

  add_index "questionnaires", ["user_id"], name: "index_questionnaires_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "address",             limit: 255
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "questionnaire_count", limit: 4
    t.integer  "bus_list_id",         limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin",                              default: false
    t.boolean  "admin_limited_access",               default: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
