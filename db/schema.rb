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

ActiveRecord::Schema.define(version: 20180726132201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "dishes", force: :cascade do |t|
    t.integer "external_id"
    t.integer "import_id",      null: false
    t.string  "name"
    t.text    "description"
    t.integer "menus_appeared"
    t.integer "times_appeared"
    t.integer "first_appeared"
    t.integer "last_appeared"
    t.decimal "lowest_price"
    t.decimal "highest_price"
    t.index ["import_id", "external_id"], name: "index_dishes_on_import_id_and_external_id", using: :btree
    t.index ["import_id"], name: "index_dishes_on_import_id", using: :btree
  end

  create_table "imports", force: :cascade do |t|
    t.string   "status",                  null: false
    t.string   "zip_filepath",            null: false
    t.integer  "processing_time_seconds"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "external_id"
    t.integer  "import_id",    null: false
    t.integer  "menu_page_id"
    t.decimal  "price"
    t.decimal  "high_price"
    t.integer  "dish_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "xpos"
    t.decimal  "ypos"
    t.index ["import_id", "menu_page_id"], name: "index_menu_items_on_import_id_and_menu_page_id", using: :btree
    t.index ["import_id"], name: "index_menu_items_on_import_id", using: :btree
  end

  create_table "menu_pages", force: :cascade do |t|
    t.integer "external_id"
    t.integer "import_id",   null: false
    t.integer "menu_id"
    t.integer "page_number"
    t.bigint  "image_id"
    t.integer "full_height"
    t.integer "full_width"
    t.string  "uuid"
    t.index ["import_id", "external_id"], name: "index_menu_pages_on_import_id_and_external_id", using: :btree
    t.index ["import_id"], name: "index_menu_pages_on_import_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.integer "external_id"
    t.integer "import_id",            null: false
    t.string  "name"
    t.string  "sponsor"
    t.string  "event"
    t.string  "venue"
    t.string  "place"
    t.string  "physical_description"
    t.string  "occasion"
    t.text    "notes"
    t.string  "call_number"
    t.text    "keywords"
    t.string  "language"
    t.date    "date"
    t.string  "location"
    t.string  "location_type"
    t.string  "currency"
    t.string  "currency_symbol"
    t.string  "status"
    t.integer "page_count"
    t.integer "dish_count"
    t.index ["event"], name: "index_menus_on_event", using: :btree
    t.index ["import_id", "external_id"], name: "index_menus_on_import_id_and_external_id", using: :btree
    t.index ["import_id"], name: "index_menus_on_import_id", using: :btree
    t.index ["place"], name: "index_menus_on_place", using: :btree
    t.index ["venue"], name: "index_menus_on_venue", using: :btree
  end

  add_foreign_key "dishes", "imports"
  add_foreign_key "menu_items", "imports"
  add_foreign_key "menu_pages", "imports"
  add_foreign_key "menus", "imports"
end
