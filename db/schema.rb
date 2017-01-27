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

ActiveRecord::Schema.define(version: 20170126204425) do

  create_table "time_entries", force: :cascade do |t|
    t.integer  "timecard_id"
    t.datetime "time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["timecard_id"], name: "index_time_entries_on_timecard_id"
  end

  create_table "timecards", force: :cascade do |t|
    t.string   "username"
    t.datetime "occurrence"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "totalhours", precision: 10, scale: 3
  end

end