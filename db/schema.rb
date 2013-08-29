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

ActiveRecord::Schema.define(:version => 20130828220041) do

  create_table "food_businesses", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
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
    t.string   "name"
    t.string   "description"
    t.integer  "location_id"
    t.string   "twitter_username"
    t.string   "facebook_username"
    t.string   "website_url"
    t.boolean  "is_admin"
    t.string   "business_type"
    t.string   "username"
  end

  add_index "food_businesses", ["reset_password_token"], :name => "index_food_businesses_on_reset_password_token", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "food_business_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "schedule_entries", :force => true do |t|
    t.integer  "food_business_id"
    t.integer  "location_id"
    t.string   "day"
    t.time     "starttime"
    t.time     "endtime"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "schedule_entries", ["food_business_id"], :name => "index_schedule_entries_on_food_business_id"
  add_index "schedule_entries", ["location_id"], :name => "index_schedule_entries_on_location_id"

end
