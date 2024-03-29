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

ActiveRecord::Schema.define(:version => 20120530121151) do

  create_table "attributes", :force => true do |t|
    t.integer  "element_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attributes", ["element_id"], :name => "index_attributes_on_element_id"

  create_table "directories", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "fixed",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "ancestry"
  end

  add_index "directories", ["ancestry"], :name => "index_directories_on_ancestry"
  add_index "directories", ["user_id"], :name => "index_directories_on_user_id"

  create_table "directories_vcoms", :id => false, :force => true do |t|
    t.integer "vcom_id"
    t.integer "directory_id"
  end

  add_index "directories_vcoms", ["directory_id"], :name => "index_directories_vcoms_on_directory_id"
  add_index "directories_vcoms", ["vcom_id"], :name => "index_directories_vcoms_on_vcom_id"

  create_table "elements", :force => true do |t|
    t.string   "name"
    t.integer  "vcom_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "elements", ["ancestry"], :name => "index_elements_on_ancestry"
  add_index "elements", ["vcom_id"], :name => "index_elements_on_vcom_id"

  create_table "searches", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "element_tokens"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vcoms", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "public"
    t.integer  "author_id"
    t.datetime "registered_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "attachment"
  end

  add_index "vcoms", ["author_id"], :name => "index_vcoms_on_author_id"

end
