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

ActiveRecord::Schema.define(:version => 20120107082825) do

  create_table "domains", :force => true do |t|
    t.integer  "truthiness"
    t.string   "name"
    t.string   "status"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.integer  "truthiness"
    t.string   "name"
    t.string   "ip_address"
    t.integer  "organization_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "object_mappings", :force => true do |t|
    t.integer  "child_id"
    t.string   "child_type"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.integer  "organization_id"
    t.integer  "domain_id"
    t.integer  "user_id"
    t.integer  "host_id"
    t.integer  "task_run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "physical_locations", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", :force => true do |t|
    t.integer  "truthiness"
    t.string   "name"
    t.string   "object_type"
    t.text     "content"
    t.integer  "organization_id"
    t.integer  "domain_id"
    t.integer  "host_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_strings", :force => true do |t|
    t.integer  "truthiness"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_runs", :force => true do |t|
    t.string   "name"
    t.integer  "task_object_id"
    t.string   "task_object_type"
    t.string   "task_options_hash"
    t.integer  "object_mapping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "truthiness"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "alias"
    t.integer  "organization_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
