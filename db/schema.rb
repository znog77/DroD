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

ActiveRecord::Schema.define(:version => 20120425161701) do

  create_table "fields", :force => true do |t|
    t.integer "instrument_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "contact"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "instruments", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.text     "specs"
    t.integer  "group_id"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lon"
    t.string   "msl"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "survey_specs", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "instrument_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "surveys", :force => true do |t|
    t.integer  "field_id"
    t.integer  "survey_spec_id"
    t.string   "type"
    t.string   "value_str"
    t.float    "value_flt"
    t.datetime "value_time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
