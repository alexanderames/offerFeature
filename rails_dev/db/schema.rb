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

ActiveRecord::Schema.define(version: 20140522143714) do

  create_table "customers", force: :cascade do |t|
    t.string   "customer_id"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_customers_on_customer_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer  "store_id"
    t.string   "customer_id"
    t.float    "lat"
    t.float    "long"
    t.datetime "event_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["customer_id"], name: "index_events_on_customer_id"
    t.index ["store_id"], name: "index_events_on_store_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "terms"
    t.string   "image_url"
    t.datetime "expiration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "retailers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "retailer_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["retailer_id"], name: "index_stores_on_retailer_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "offer_id"
    t.string   "task_type"
    t.float    "amount"
    t.text     "content"
    t.string   "url"
    t.string   "thumbnail_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["offer_id"], name: "index_tasks_on_offer_id"
  end

end
