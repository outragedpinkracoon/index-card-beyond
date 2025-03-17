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

ActiveRecord::Schema[8.0].define(version: 2025_03_17_212932) do
  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "str_mod"
    t.integer "dex_mod"
    t.integer "con_mod"
    t.integer "int_mod"
    t.integer "wis_mod"
    t.integer "cha_mod"
    t.integer "basic_mod"
    t.integer "weapons_and_tools_mod"
    t.integer "guns_mod"
    t.integer "energy_and_magic_mod"
    t.integer "ultimate_mod"
    t.integer "defense_mod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "life_form_attribute_modifiers", force: :cascade do |t|
    t.integer "life_form_id", null: false
    t.integer "str_mod"
    t.integer "dex_mod"
    t.integer "con_mod"
    t.integer "int_mod"
    t.integer "wis_mod"
    t.integer "cha_mod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["life_form_id"], name: "index_life_form_attribute_modifiers_on_life_form_id"
  end

  create_table "life_form_effort_modifiers", force: :cascade do |t|
    t.integer "life_form_id", null: false
    t.integer "basic_mod"
    t.integer "weapons_and_tools_mod"
    t.integer "guns_mod"
    t.integer "energy_and_magic_mod"
    t.integer "ultimate_mod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["life_form_id"], name: "index_life_form_effort_modifiers_on_life_form_id"
  end

  create_table "life_forms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "life_form_attribute_modifiers", "life_forms"
  add_foreign_key "life_form_effort_modifiers", "life_forms"
end
