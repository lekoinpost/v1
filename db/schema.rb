# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_05_092331) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "gardner_id", null: false
    t.bigint "giver_id", null: false
    t.integer "quantity"
    t.string "compost_type"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gardner_id"], name: "index_appointments_on_gardner_id"
    t.index ["giver_id"], name: "index_appointments_on_giver_id"
  end

  create_table "appointments_tables", force: :cascade do |t|
    t.bigint "giver_id", null: false
    t.bigint "gardener_id", null: false
    t.date "date"
    t.string "quantity"
    t.string "compost_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gardener_id"], name: "index_appointments_tables_on_gardener_id"
    t.index ["giver_id"], name: "index_appointments_tables_on_giver_id"
  end

  create_table "givers_gardners_points", force: :cascade do |t|
    t.bigint "gardner_id", null: false
    t.bigint "giver_id", null: false
    t.integer "nb_of_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gardner_id"], name: "index_givers_gardners_points_on_gardner_id"
    t.index ["giver_id"], name: "index_givers_gardners_points_on_giver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.string "garden_name"
    t.string "description"
    t.integer "nb_of_points_for_a_gift"
    t.string "street"
    t.string "zipcode"
    t.string "city"
    t.string "slug"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "products", limit: 30, default: [], array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "users", column: "gardner_id"
  add_foreign_key "appointments", "users", column: "giver_id"
  add_foreign_key "appointments_tables", "users", column: "gardener_id"
  add_foreign_key "appointments_tables", "users", column: "giver_id"
  add_foreign_key "givers_gardners_points", "users", column: "gardner_id"
  add_foreign_key "givers_gardners_points", "users", column: "giver_id"
end
