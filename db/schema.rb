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

ActiveRecord::Schema.define(version: 20180302074242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "manufacturers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "verified"
    t.string   "ul"
    t.string   "ul_c"
    t.string   "source"
    t.string   "source_id"
  end

  create_table "material_attribute_values", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "value"
    t.uuid     "material_attribute_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "value_type"
    t.index ["material_attribute_id"], name: "index_material_attribute_values_on_material_attribute_id", using: :btree
  end

  create_table "material_attributes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.uuid   "material_id"
    t.index ["material_id"], name: "index_material_attributes_on_material_id", using: :btree
  end

  create_table "materials", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "function"
    t.string   "group"
    t.uuid     "manufacturer_id"
    t.string   "name"
    t.string   "link"
    t.text     "remark"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "flexible"
    t.string   "additional",          default: [],              array: true
    t.string   "ul_94"
    t.boolean  "accept_equivalent"
    t.boolean  "verified"
    t.string   "source"
    t.string   "circuitdata_version"
    t.string   "source_id"
    t.index ["manufacturer_id"], name: "index_materials_on_manufacturer_id", using: :btree
  end

  add_foreign_key "material_attribute_values", "material_attributes"
  add_foreign_key "material_attributes", "materials"
  add_foreign_key "materials", "manufacturers"
end
