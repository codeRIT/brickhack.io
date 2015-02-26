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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150226185649) do

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "recipients"
    t.text     "body"
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "delivered_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "questionnaires", :force => true do |t|
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
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
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
    t.boolean  "agreement_accepted",    :default => false
    t.string   "acc_status",            :default => "pending"
    t.integer  "acc_status_author_id"
    t.datetime "acc_status_date"
  end

  add_index "questionnaires", ["user_id"], :name => "index_questionnaires_on_user_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "questionnaire_count"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false
    t.boolean  "admin_read_only",        :default => false
    t.string   "provider"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
