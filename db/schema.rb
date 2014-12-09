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

ActiveRecord::Schema.define(version: 20141208175201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blasts", force: true do |t|
    t.string   "name"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_id"
  end

  create_table "check_ins", force: true do |t|
    t.integer  "event_id"
    t.integer  "citizen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "check_ins", ["citizen_id"], name: "index_check_ins_on_citizen_id", using: :btree
  add_index "check_ins", ["event_id"], name: "index_check_ins_on_event_id", using: :btree

  create_table "citizens", force: true do |t|
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nationbuilder_id"
    t.string   "full_name"
    t.string   "email"
    t.boolean  "mobile_opt_in",    default: true, null: false
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

  create_table "keyword_listeners", force: true do |t|
    t.string   "keyword",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listening_id",   null: false
    t.string   "listening_type", null: false
  end

  add_index "keyword_listeners", ["keyword"], name: "index_keyword_listeners_on_keyword", unique: true, using: :btree
  add_index "keyword_listeners", ["listening_id", "listening_type"], name: "index_keyword_listeners_on_listening_id_and_listening_type", using: :btree

  create_table "listed_citizens", force: true do |t|
    t.integer  "citizen_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listed_citizens", ["citizen_id", "list_id"], name: "index_listed_citizens_on_citizen_id_and_list_id", using: :btree
  add_index "listed_citizens", ["list_id", "citizen_id"], name: "index_listed_citizens_on_list_id_and_citizen_id", using: :btree

  create_table "lists", force: true do |t|
    t.string   "name"
    t.string   "collected_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "number_listeners", force: true do |t|
    t.string   "number",         null: false
    t.integer  "listening_id",   null: false
    t.string   "listening_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "number_listeners", ["listening_id", "listening_type"], name: "index_number_listeners_on_listening_id_and_listening_type", using: :btree
  add_index "number_listeners", ["number"], name: "index_number_listeners_on_number", unique: true, using: :btree

  create_table "poll_choices", force: true do |t|
    t.integer  "poll_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poll_choices", ["poll_id"], name: "index_poll_choices_on_poll_id", using: :btree

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
    t.integer  "blast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "autoresponse"
    t.string   "citizen_attribute"
    t.text     "nationbuilder_tags", default: [], array: true
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "poll_choice_id"
    t.integer  "citizen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["citizen_id"], name: "index_votes_on_citizen_id", using: :btree
  add_index "votes", ["poll_choice_id"], name: "index_votes_on_poll_choice_id", using: :btree

end
