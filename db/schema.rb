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

ActiveRecord::Schema.define(version: 20160710151332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "donor_list_id"
    t.string   "body"
    t.index ["donor_list_id"], name: "index_campaigns_on_donor_list_id", using: :btree
    t.index ["school_id"], name: "index_campaigns_on_school_id", using: :btree
    t.index ["user_id"], name: "index_campaigns_on_user_id", using: :btree
  end

  create_table "conversions", force: :cascade do |t|
    t.boolean  "converted",  default: false
    t.datetime "hit_time"
    t.string   "identifier"
    t.integer  "school_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["school_id"], name: "index_conversions_on_school_id", using: :btree
  end

  create_table "donor_lists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donor_lists_donors", id: false, force: :cascade do |t|
    t.integer "donor_id",      null: false
    t.integer "donor_list_id", null: false
    t.index ["donor_id"], name: "index_donor_lists_donors_on_donor_id", using: :btree
    t.index ["donor_list_id"], name: "index_donor_lists_donors_on_donor_list_id", using: :btree
  end

  create_table "donors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "school_id"
    t.string   "key"
    t.string   "braintree_customer_id"
    t.string   "phone_number"
    t.string   "gift_frequency"
    t.integer  "subscription_id"
    t.date     "subscription_start"
    t.string   "subscription_total"
    t.index ["school_id"], name: "index_donors_on_school_id", using: :btree
    t.index ["subscription_id"], name: "index_donors_on_subscription_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_forms_on_school_id", using: :btree
  end

  create_table "gifts", force: :cascade do |t|
    t.string   "total"
    t.integer  "school_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "donor_id"
    t.integer  "campaign_id"
    t.string   "designation"
    t.string   "gift_type"
    t.index ["campaign_id"], name: "index_gifts_on_campaign_id", using: :btree
    t.index ["donor_id"], name: "index_gifts_on_donor_id", using: :btree
    t.index ["school_id"], name: "index_gifts_on_school_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "designation",              array: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "school_id"
    t.integer  "interval"
    t.index ["school_id"], name: "index_subscriptions_on_school_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_users_on_school_id", using: :btree
  end

  add_foreign_key "campaigns", "donor_lists"
  add_foreign_key "campaigns", "schools"
  add_foreign_key "campaigns", "users"
  add_foreign_key "conversions", "schools"
  add_foreign_key "donors", "schools"
  add_foreign_key "donors", "subscriptions"
  add_foreign_key "forms", "schools"
  add_foreign_key "gifts", "campaigns"
  add_foreign_key "gifts", "donors"
  add_foreign_key "gifts", "schools"
  add_foreign_key "subscriptions", "schools"
  add_foreign_key "users", "schools"
end
