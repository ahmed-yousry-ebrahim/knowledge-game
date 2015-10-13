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

ActiveRecord::Schema.define(version: 20151013113703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: true do |t|
    t.string   "title"
    t.string   "option1"
    t.string   "option2"
    t.string   "option3"
    t.string   "option4"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "fbid"
    t.integer  "lifes",      default: 3
    t.string   "category"
    t.integer  "score",      default: 0
    t.integer  "high_score", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
