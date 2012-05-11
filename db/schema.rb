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

ActiveRecord::Schema.define(:version => 20120505223935) do

  create_table "pages", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "section_id",     :null => false
    t.string   "title"
    t.string   "tags"
    t.text     "content"
    t.datetime "created_on"
    t.integer  "created_by"
    t.datetime "last_update"
    t.integer  "last_update_by"
  end

  add_index "pages", ["name"], :name => "index_pages_on_name", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "sections", :force => true do |t|
    t.string "name",        :null => false
    t.string "description"
    t.string "status"
  end

  add_index "sections", ["name"], :name => "index_sections_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "github_uid",     :null => false
    t.string   "name"
    t.string   "username",       :null => false
    t.string   "email",          :null => false
    t.string   "site_url"
    t.string   "gravatar_token"
    t.datetime "banned_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["github_uid"], :name => "index_users_on_github_uid", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
