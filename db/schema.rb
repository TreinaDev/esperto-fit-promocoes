# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_30_205024) do

  create_table "partner_companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "address"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.decimal "discount"
    t.integer "discount_duration"
    t.boolean "discount_duration_undefined", default: false
    t.index ["cnpj"], name: "index_partner_companies_on_cnpj", unique: true
    t.index ["user_id"], name: "index_partner_companies_on_user_id"
  end

  create_table "partner_company_employees", force: :cascade do |t|
    t.string "cpf"
    t.integer "partner_company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_company_id"], name: "index_partner_company_employees_on_partner_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "social_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "partner_companies", "users"
  add_foreign_key "partner_company_employees", "partner_companies"
end
