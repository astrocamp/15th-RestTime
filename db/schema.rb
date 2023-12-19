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

<<<<<<< HEAD
ActiveRecord::Schema[7.1].define(version: 2023_12_18_061344) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

=======
ActiveRecord::Schema[7.1].define(version: 2023_12_18_180432) do
>>>>>>> 075d977 (user hasone shop)
  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.boolean "onsale", default: false
    t.datetime "deleted_at"
    t.integer "store_id"
    t.integer "position"
    t.datetime "publish_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_hour"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "title"
    t.string "tel"
    t.text "description"
    t.string "city"
    t.string "district"
    t.text "street"
    t.datetime "deleted_at"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "shops", "users"
end
