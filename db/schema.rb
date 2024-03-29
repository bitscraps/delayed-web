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

ActiveRecord::Schema.define(version: 20140805180416) do

  create_table "notifications", force: true do |t|
    t.string   "departing_from"
    t.string   "departing_from_code"
    t.string   "arriving_at"
    t.string   "arriving_at_code"
    t.string   "departing_time"
    t.string   "repeating"
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "arrival_time"
  end

  create_table "sent_notifications", force: true do |t|
    t.string   "channel"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
