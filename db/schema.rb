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

ActiveRecord::Schema.define(version: 2021_02_14_151058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "black_listed_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.bigint "black_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["black_list_id"], name: "index_black_listed_users_on_black_list_id"
  end

  create_table "black_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_black_lists_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "body", limit: 200, default: "", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "body", limit: 200, default: "", null: false
    t.boolean "read", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "surname"
    t.string "avatar"
    t.string "role", default: "user", null: false
    t.boolean "only_read", default: true
    t.datetime "only_read_end"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "black_listed_users", "black_lists"
  add_foreign_key "black_listed_users", "users"
  add_foreign_key "black_lists", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "messages", "users"
end
