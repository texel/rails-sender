# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090607192551) do

  create_table "accounts", :force => true do |t|
    t.string   "api_id"
    t.string   "api_name"
    t.string   "api_password"
    t.string   "api_email"
    t.string   "api_user_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "envelopes", :force => true do |t|
    t.string   "account_id"
    t.string   "recipient_name"
    t.string   "recipient_email"
    t.string   "subject"
    t.string   "email_blurb"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.string   "ds_id"
    t.string   "ds_status"
    t.datetime "status_updated_at"
    t.string   "state"
    t.integer  "credential_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", :force => true do |t|
    t.integer  "envelope_id"
    t.string   "name"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "api_login"
    t.string   "api_password"
    t.string   "api_account_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
