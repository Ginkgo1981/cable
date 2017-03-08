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

ActiveRecord::Schema.define(version: 20170308082405) do

  create_table "dm_zxdm", primary_key: "xxdm", id: :string, limit: 12, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "sxdm", limit: 9,   null: false
    t.string "xxmc", limit: 100, null: false
    t.index ["xxdm"], name: "PK_GK_DM_zxdm_1", unique: true, using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "cell",        limit: 50
    t.string   "passwd"
    t.string   "salt"
    t.string   "name",                   default: ""
    t.integer  "sex"
    t.string   "email",       limit: 50
    t.string   "token",       limit: 50
    t.string   "identity_id", limit: 50
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "yx_details", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "yxdm",    limit: 5,     null: false
    t.string  "yxmc",    limit: 64,    null: false
    t.string  "dq",      limit: 50
    t.string  "xxdz",    limit: 50
    t.string  "xxwz",    limit: 50
    t.string  "xxdh",    limit: 50
    t.text    "xxjj",    limit: 65535
    t.text    "zsjz",    limit: 65535
    t.text    "zxxx",    limit: 65535
    t.text    "brief",   limit: 65535
    t.integer "IsMaked"
    t.index ["ID"], name: "PK_GK_sys_SchoolDetail", unique: true, using: :btree
  end

  create_table "zy_details", primary_key: "ID", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "zydm",        limit: 50,    null: false
    t.string "zymc",        limit: 50,    null: false
    t.string "ccdm",        limit: 50,    null: false
    t.text   "goal",        limit: 65535
    t.text   "claim",       limit: 65535
    t.text   "trunkcourse", limit: 65535
    t.text   "course",      limit: 65535
    t.index ["ID"], name: "PK_GK_zy_Detail", unique: true, using: :btree
  end

end
