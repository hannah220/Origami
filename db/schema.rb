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

ActiveRecord::Schema.define(version: 20180912142324) do

  create_table "billing_addrs", force: :cascade do |t|
    t.string "street"
    t.string "postal"
    t.string "zip"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_colors", force: :cascade do |t|
    t.integer "item_id"
    t.integer "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_sizes", force: :cascade do |t|
    t.integer "item_id"
    t.integer "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items_colors", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "color_id"
    t.index ["color_id"], name: "index_items_colors_on_color_id"
    t.index ["item_id"], name: "index_items_colors_on_item_id"
  end

  create_table "items_options", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "option_id"
    t.index ["item_id"], name: "index_items_options_on_item_id"
    t.index ["option_id"], name: "index_items_options_on_option_id"
  end

  create_table "items_sizes", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "size_id"
    t.index ["item_id"], name: "index_items_sizes_on_item_id"
    t.index ["size_id"], name: "index_items_sizes_on_size_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_lines", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "item_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "order_date"
    t.datetime "ship_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shipping_addrs", force: :cascade do |t|
    t.string "street"
    t.string "postal"
    t.string "zip"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "password_digest"
  end

end
