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

ActiveRecord::Schema.define(version: 2021_03_30_192220) do

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "zipcode"
    t.float "wallet", default: 0.0
  end

  create_table "flavors", force: :cascade do |t|
    t.string "name"
  end

  create_table "flavors_icecreams", force: :cascade do |t|
    t.integer "icecream_id"
    t.integer "flavor_id"
    t.index ["flavor_id"], name: "index_flavors_icecreams_on_flavor_id"
    t.index ["icecream_id"], name: "index_flavors_icecreams_on_icecream_id"
  end

  create_table "icecreams", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "truck_id"
  end

  create_table "icecreams_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "icecream_id"
    t.integer "quantity"
    t.float "total", default: 0.0
  end

  create_table "orders", force: :cascade do |t|
    t.float "total", default: 0.0
    t.boolean "confirmed", default: false
    t.boolean "delivered", default: false
    t.integer "truck_id"
    t.integer "customer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trucks", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "zipcode"
    t.boolean "online", default: true
  end

end
