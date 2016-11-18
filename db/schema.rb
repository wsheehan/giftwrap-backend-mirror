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

ActiveRecord::Schema.define(version: 20161118001925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_emails", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_campaign_emails_on_campaign_id", using: :btree
  end

  create_table "campaign_texts", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "body"
    t.string   "from"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id"], name: "index_campaign_texts_on_campaign_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "client_id"
    t.integer  "donor_list_id"
    t.index ["client_id"], name: "index_campaigns_on_client_id", using: :btree
    t.index ["donor_list_id"], name: "index_campaigns_on_donor_list_id", using: :btree
    t.index ["user_id"], name: "index_campaigns_on_user_id", using: :btree
  end

  create_table "client_policies", force: :cascade do |t|
    t.string   "app_id",         null: false
    t.string   "app_public_key"
    t.string   "app_secret_key"
    t.integer  "client_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["client_id"], name: "index_client_policies_on_client_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donor_lists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "client_id"
    t.string   "description"
    t.index ["client_id"], name: "index_donor_lists_on_client_id", using: :btree
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
    t.string   "key"
    t.string   "braintree_customer_id"
    t.string   "phone_number"
    t.string   "gift_frequency"
    t.integer  "subscription_id"
    t.date     "subscription_start"
    t.string   "subscription_total"
    t.string   "affiliation"
    t.integer  "class_year"
    t.integer  "client_id"
    t.integer  "campaign_id"
    t.index ["campaign_id"], name: "index_donors_on_campaign_id", using: :btree
    t.index ["client_id"], name: "index_donors_on_client_id", using: :btree
    t.index ["subscription_id"], name: "index_donors_on_subscription_id", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "client_id"
    t.index ["client_id"], name: "index_forms_on_client_id", using: :btree
  end

  create_table "gifts", force: :cascade do |t|
    t.string   "total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "donor_id"
    t.integer  "campaign_id"
    t.string   "designation"
    t.string   "gift_type"
    t.integer  "client_id"
    t.index ["campaign_id"], name: "index_gifts_on_campaign_id", using: :btree
    t.index ["client_id"], name: "index_gifts_on_client_id", using: :btree
    t.index ["donor_id"], name: "index_gifts_on_donor_id", using: :btree
  end

  create_table "metric_campaign_conversions", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "donor_id"
    t.integer  "metric_id"
    t.string   "gift_method"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "gift_id"
    t.boolean  "subscription", default: false
    t.index ["campaign_id"], name: "index_metric_campaign_conversions_on_campaign_id", using: :btree
    t.index ["donor_id"], name: "index_metric_campaign_conversions_on_donor_id", using: :btree
    t.index ["gift_id"], name: "index_metric_campaign_conversions_on_gift_id", using: :btree
    t.index ["metric_id"], name: "index_metric_campaign_conversions_on_metric_id", using: :btree
  end

  create_table "metric_campaign_hellos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metric_form_conversions", force: :cascade do |t|
    t.datetime "hit_time"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "metric_id"
    t.integer  "metric_campaign_conversions_id"
    t.integer  "gift_id"
    t.integer  "donor_id"
    t.index ["donor_id"], name: "index_metric_form_conversions_on_donor_id", using: :btree
    t.index ["gift_id"], name: "index_metric_form_conversions_on_gift_id", using: :btree
    t.index ["metric_campaign_conversions_id"], name: "index_metric_form_conversions_on_metric_campaign_conversions_id", using: :btree
    t.index ["metric_id"], name: "index_metric_form_conversions_on_metric_id", using: :btree
  end

  create_table "metrics", force: :cascade do |t|
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_metrics_on_client_id", using: :btree
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
    t.integer  "interval"
    t.integer  "client_id"
    t.index ["client_id"], name: "index_subscriptions_on_client_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "client_id"
    t.string   "password_digest"
    t.index ["client_id"], name: "index_users_on_client_id", using: :btree
  end

  add_foreign_key "campaign_emails", "campaigns"
  add_foreign_key "campaign_texts", "campaigns"
  add_foreign_key "campaigns", "clients"
  add_foreign_key "campaigns", "donor_lists"
  add_foreign_key "campaigns", "users"
  add_foreign_key "donor_lists", "clients"
  add_foreign_key "donors", "campaigns"
  add_foreign_key "donors", "clients"
  add_foreign_key "donors", "subscriptions"
  add_foreign_key "forms", "clients"
  add_foreign_key "gifts", "campaigns"
  add_foreign_key "gifts", "clients"
  add_foreign_key "gifts", "donors"
  add_foreign_key "metric_campaign_conversions", "campaigns"
  add_foreign_key "metric_campaign_conversions", "donors"
  add_foreign_key "metric_campaign_conversions", "gifts"
  add_foreign_key "metric_campaign_conversions", "metrics"
  add_foreign_key "metric_form_conversions", "donors"
  add_foreign_key "metric_form_conversions", "gifts"
  add_foreign_key "metric_form_conversions", "metric_campaign_conversions", column: "metric_campaign_conversions_id"
  add_foreign_key "metric_form_conversions", "metrics"
  add_foreign_key "metrics", "clients"
  add_foreign_key "subscriptions", "clients"
  add_foreign_key "users", "clients"
end
