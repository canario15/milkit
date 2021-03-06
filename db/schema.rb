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

ActiveRecord::Schema.define(version: 2019_12_21_205541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "cows", force: :cascade do |t|
    t.string "caravan"
    t.date "birth_date"
    t.integer "status"
    t.bigint "tambo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cow_type"
    t.date "due_date"
    t.integer "service_num"
    t.date "service_date"
    t.date "date"
    t.string "bull"
    t.index ["tambo_id"], name: "index_cows_on_tambo_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "cow_id"
    t.date "date_event"
    t.integer "action"
    t.string "bull"
    t.date "notify_date"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notify_description"
    t.index ["cow_id"], name: "index_events_on_cow_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "tambo_id"
    t.bigint "cow_id"
    t.bigint "event_id"
    t.bigint "user_id"
    t.date "notify_date"
    t.boolean "read"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["cow_id"], name: "index_notifications_on_cow_id"
    t.index ["event_id"], name: "index_notifications_on_event_id"
    t.index ["tambo_id"], name: "index_notifications_on_tambo_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "tambos", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_contact"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notification_color"
    t.index ["user_id"], name: "index_tambos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cows", "tambos"
  add_foreign_key "events", "cows"
  add_foreign_key "notifications", "cows"
  add_foreign_key "notifications", "events"
  add_foreign_key "notifications", "tambos"
  add_foreign_key "notifications", "users"
  add_foreign_key "tambos", "users"
end
