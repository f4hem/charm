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

ActiveRecord::Schema.define(:version => 20120825195921) do

  create_table "charm_callbacks", :force => true do |t|
    t.string   "redirect_uri"
    t.integer  "client_id"
    t.string   "scope"
    t.string   "response_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charm_clients", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.string   "client_id"
    t.string   "client_secret"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "response_type"
    t.string   "redirect_uri"
    t.string   "scope"
  end

  create_table "charm_tokens", :force => true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.string   "scope"
    t.datetime "expire_at"
    t.datetime "valid_thru"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flirt_events", :force => true do |t|
    t.string   "scope"
    t.integer  "token_id"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
