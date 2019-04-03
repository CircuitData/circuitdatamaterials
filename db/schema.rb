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

ActiveRecord::Schema.define(version: 2019_04_03_061539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "manufacturers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.string "ul"
    t.string "ul_c"
    t.string "source"
    t.string "source_id"
  end

  create_table "materials", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "function"
    t.string "group"
    t.uuid "manufacturer_id"
    t.string "name"
    t.string "link"
    t.text "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "flexible"
    t.string "ul_94"
    t.boolean "accept_equivalent"
    t.boolean "verified"
    t.string "source"
    t.string "version"
    t.string "source_id"
    t.integer "ipc_standard"
    t.text "additional"
    t.boolean "woven_reinforcement"
    t.decimal "cti"
    t.decimal "df"
    t.decimal "dielectric_breakdown"
    t.decimal "dk"
    t.decimal "electric_strength"
    t.decimal "frequency"
    t.decimal "mot"
    t.decimal "resin_content"
    t.decimal "t260"
    t.decimal "t280"
    t.decimal "t300"
    t.integer "td_min"
    t.integer "tg_min"
    t.decimal "thermal_conductivity"
    t.decimal "thickness"
    t.decimal "volume_resistivity"
    t.decimal "water_absorption"
    t.decimal "z_cte"
    t.decimal "z_cte_after_tg"
    t.decimal "z_cte_before_tg"
    t.integer "ipc_slash_sheet", array: true
    t.string "filler", array: true
    t.string "finish"
    t.string "flame_retardant"
    t.string "foil_roughness"
    t.string "ipc_sm_840_class"
    t.string "reinforcement"
    t.string "resin"
    t.index ["manufacturer_id", "name"], name: "index_materials_on_manufacturer_id_and_name", unique: true
    t.index ["manufacturer_id"], name: "index_materials_on_manufacturer_id"
    t.index ["name"], name: "index_materials_on_name", unique: true, where: "(manufacturer_id IS NULL)"
  end

  add_foreign_key "materials", "manufacturers"
end
