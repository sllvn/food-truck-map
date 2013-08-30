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
    t.string   "name"
    t.string   "description"
    t.integer  "location_id"
    t.string   "twitter_username"
    t.string   "facebook_username"
    t.string   "website_url"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "business_type"
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedule_entries", :force => true do |t|
    t.integer  "food_business_id"
    t.integer  "location_id"
    t.string   "day"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "schedule_entries", ["food_business_id"], :name => "index_schedule_entries_on_food_business_id"
  add_index "schedule_entries", ["location_id"], :name => "index_schedule_entries_on_location_id"

end
