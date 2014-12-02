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

ActiveRecord::Schema.define(version: 20141201184159) do

  create_table "blasts", force: true do |t|
    t.string   "name"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blasts_citizens", id: false, force: true do |t|
    t.integer "blast_id",   null: false
    t.integer "citizen_id", null: false
  end

  add_index "blasts_citizens", ["blast_id", "citizen_id"], name: "index_blasts_citizens_on_blast_id_and_citizen_id"
  add_index "blasts_citizens", ["citizen_id", "blast_id"], name: "index_blasts_citizens_on_citizen_id_and_blast_id"

  create_table "check_ins", force: true do |t|
    t.integer  "event_id"
    t.integer  "citizen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "check_ins", ["citizen_id"], name: "index_check_ins_on_citizen_id"
  add_index "check_ins", ["event_id"], name: "index_check_ins_on_event_id"

  create_table "citizens", force: true do |t|
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nationbuilder_id"
    t.string   "full_name"
    t.string   "email"
    t.boolean  "mobile_opt_in"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "keyword"
    t.string   "autoresponse"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nationbuilder_tag"
  end

  create_table "listeners", force: true do |t|
    t.string   "keyword",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listening_id",   null: false
    t.string   "listening_type", null: false
  end

  add_index "listeners", ["keyword"], name: "index_listeners_on_keyword", unique: true
  add_index "listeners", ["listening_id", "listening_type"], name: "index_listeners_on_listening_id_and_listening_type"

  create_table "poll_choices", force: true do |t|
    t.integer  "poll_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poll_choices", ["poll_id"], name: "index_poll_choices_on_poll_id"

  create_table "polls", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "strategy"
    t.string   "nationbuilder_tag"
  end

  create_table "questions", force: true do |t|
    t.string   "prompt"
    t.string   "nationbuilder_field"
    t.integer  "blast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "poll_choice_id"
    t.integer  "citizen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["citizen_id"], name: "index_votes_on_citizen_id"
  add_index "votes", ["poll_choice_id"], name: "index_votes_on_poll_choice_id"

end
