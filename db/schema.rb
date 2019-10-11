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

ActiveRecord::Schema.define(version: 2019_10_11_051039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "manufacturers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.citext "name", null: false
    t.string "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.string "ul"
    t.string "ul_c"
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
  end

  create_table "materials", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "function", null: false
    t.string "group"
    t.uuid "manufacturer_id"
    t.string "name", null: false
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "flexible"
    t.string "ul_94"
    t.integer "ipc_standard"
    t.integer "cti"
    t.decimal "df"
    t.decimal "dielectric_breakdown"
    t.decimal "dk"
    t.decimal "electric_strength"
    t.decimal "mot"
    t.decimal "t260"
    t.decimal "t280"
    t.decimal "t300"
    t.integer "td_min"
    t.integer "tg_min"
    t.decimal "thermal_conductivity"
    t.decimal "water_absorption"
    t.decimal "z_cte"
    t.decimal "z_cte_after_tg"
    t.decimal "z_cte_before_tg"
    t.integer "ipc_slash_sheet", array: true
    t.string "finish"
    t.string "foil_roughness"
    t.string "ipc_sm_840_class"
    t.boolean "verified", default: false, null: false
    t.index ["manufacturer_id", "name"], name: "index_materials_on_manufacturer_id_and_name", unique: true
    t.index ["manufacturer_id"], name: "index_materials_on_manufacturer_id"
    t.index ["name"], name: "index_materials_on_name", unique: true, where: "(manufacturer_id IS NULL)"
  end

  add_foreign_key "materials", "manufacturers"
end
