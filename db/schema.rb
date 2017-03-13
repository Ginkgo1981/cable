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

ActiveRecord::Schema.define(version: 20170311155206) do

  create_table "bookmarkings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "bookmarkable_id"
    t.string   "bookmarkable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "dm_zxdm", primary_key: "xxdm", id: :string, limit: 12, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "sxdm", limit: 9,   null: false
    t.string "xxmc", limit: 100, null: false
    t.index ["xxdm"], name: "PK_GK_DM_zxdm_1", unique: true, using: :btree
  end

  create_table "dm_zxdms", primary_key: "xxdm", id: :string, limit: 12, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "sxdm", limit: 9,   null: false
    t.string "xxmc", limit: 100, null: false
    t.index ["xxdm"], name: "PK_GK_DM_zxdm_1", unique: true, using: :btree
  end

  create_table "followings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "message_bookmarkings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_likings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text     "content",         limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "channel"
    t.string   "type"
    t.integer  "receiver_id"
    t.integer  "attachment_id"
    t.string   "attachment_type"
  end

  create_table "staffs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "title"
    t.string   "description"
    t.text     "content",          limit: 65535
    t.string   "coverage_img_url"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "province"
    t.string   "city"
    t.string   "school"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "yxmc"
    t.string   "yxdm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "cell",                      limit: 50
    t.string   "passwd"
    t.string   "salt"
    t.string   "name",                                 default: ""
    t.integer  "sex"
    t.string   "email",                     limit: 50
    t.string   "token",                     limit: 50
    t.string   "identity_id",               limit: 50
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "identity_type"
    t.string   "sms_auth_code"
    t.string   "nick_name"
    t.string   "avatar_url"
    t.string   "union_id"
    t.string   "mini_app_open_id"
    t.string   "web_authorization_open_id"
    t.string   "offical_account_open_id"
    t.datetime "subscribe_at"
    t.datetime "unsubscribe_at"
    t.string   "device_info"
    t.boolean  "register_status"
    t.datetime "register_at"
    t.boolean  "online_status"
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
