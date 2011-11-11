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

ActiveRecord::Schema.define(:version => 20111111001416) do

  create_table "glucose_readings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "glucose_value"
    t.datetime "reading_at"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meal_code"
  end

  add_index "glucose_readings", ["meal_code"], :name => "index_glucose_readings_on_meal_code"
  add_index "glucose_readings", ["reading_at"], :name => "index_glucose_readings_on_reading_at"
  add_index "glucose_readings", ["user_id"], :name => "index_glucose_readings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["user_name"], :name => "index_users_on_user_name", :unique => true

end
