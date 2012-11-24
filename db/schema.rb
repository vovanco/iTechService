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

ActiveRecord::Schema.define(:version => 20121122054853) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "device_tasks", :force => true do |t|
    t.integer  "device_id"
    t.integer  "task_id"
    t.boolean  "done"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "cost"
    t.datetime "done_at"
  end

  add_index "device_tasks", ["device_id"], :name => "index_device_tasks_on_device_id"
  add_index "device_tasks", ["task_id"], :name => "index_device_tasks_on_task_id"

  create_table "device_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "devices", :force => true do |t|
    t.integer  "device_type_id"
    t.string   "ticket_number"
    t.integer  "client_id"
    t.text     "comment"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "done_at"
    t.string   "serial_number"
  end

  add_index "devices", ["client_id"], :name => "index_devices_on_client_id"
  add_index "devices", ["device_type_id"], :name => "index_devices_on_device_type_id"
  add_index "devices", ["ticket_number"], :name => "index_devices_on_ticket_number"

  create_table "history_records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.string   "column_name"
    t.string   "column_type"
    t.string   "old_value"
    t.string   "new_value"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "history_records", ["new_value"], :name => "index_history_records_on_new_value"
  add_index "history_records", ["object_id", "object_type"], :name => "index_history_records_on_object_id_and_object_type"
  add_index "history_records", ["old_value", "new_value"], :name => "index_history_records_on_old_value_and_new_value"
  add_index "history_records", ["old_value"], :name => "index_history_records_on_old_value"
  add_index "history_records", ["user_id"], :name => "index_history_records_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "duration"
    t.decimal  "cost"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "priority",   :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "role"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "email",                  :default => ""
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
