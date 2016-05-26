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

ActiveRecord::Schema.define(version: 20160526182042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "campaigns", ["school_id"], name: "index_campaigns_on_school_id", using: :btree
  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "donor_lists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donor_lists_donors", id: false, force: :cascade do |t|
    t.integer "donor_id",      null: false
    t.integer "donor_list_id", null: false
  end

  add_index "donor_lists_donors", ["donor_id"], name: "index_donor_lists_donors_on_donor_id", using: :btree
  add_index "donor_lists_donors", ["donor_list_id"], name: "index_donor_lists_donors_on_donor_list_id", using: :btree

  create_table "donors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "school_id"
    t.string   "key"
  end

  add_index "donors", ["school_id"], name: "index_donors_on_school_id", using: :btree

  create_table "forms", force: :cascade do |t|
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "forms", ["school_id"], name: "index_forms_on_school_id", using: :btree

  create_table "gifts", force: :cascade do |t|
    t.string   "total"
    t.integer  "school_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "donor_id"
    t.integer  "campaign_id"
  end

  add_index "gifts", ["campaign_id"], name: "index_gifts_on_campaign_id", using: :btree
  add_index "gifts", ["donor_id"], name: "index_gifts_on_donor_id", using: :btree
  add_index "gifts", ["school_id"], name: "index_gifts_on_school_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

  add_foreign_key "campaigns", "schools"
  add_foreign_key "campaigns", "users"
  add_foreign_key "donors", "schools"
  add_foreign_key "forms", "schools"
  add_foreign_key "gifts", "campaigns"
  add_foreign_key "gifts", "donors"
  add_foreign_key "gifts", "schools"
  add_foreign_key "users", "schools"
end
