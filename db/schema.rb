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

ActiveRecord::Schema.define(version: 20170616160244) do

  create_table "askcards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "attachment_id"
    t.string   "attachment_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "beans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "bean_family_id"
    t.string   "bean_family_type"
    t.string   "dsin"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "bookmarkings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "bookmarkable_id"
    t.string   "bookmarkable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.integer  "university_id"
    t.integer  "teacher_id"
    t.string   "note"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cells", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "cell"
    t.string   "code"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.integer  "hot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "follower_id"
    t.string   "follower_type"
  end

  create_table "forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "form_id"
    t.datetime "expired_at"
    t.integer  "status"
    t.string   "content"
    t.string   "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "group_id"
    t.integer  "init_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "jiangsu_sats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "student_id"
    t.integer  "score_chinese"
    t.integer  "score_english"
    t.integer  "score_math"
    t.integer  "score_sum"
    t.string   "kl"
    t.string   "km_1"
    t.string   "km_2"
    t.string   "score_km_1"
    t.string   "score_km_2"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "likings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "comment"
  end

  create_table "major_hots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.integer  "hot",        default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "majors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "university_id"
    t.string   "goal"
    t.string   "claim"
    t.string   "course"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "content",       limit: 65535
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
    t.text     "content",       limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "channel"
    t.string   "type"
    t.datetime "expired_at"
    t.integer  "state"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "staff_id"
    t.integer  "university_id"
    t.string   "direction"
    t.string   "img_url"
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "key"
    t.string   "img_url"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skycodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "campaign_id"
    t.integer  "university_id"
    t.integer  "teacher_id"
    t.string   "name"
    t.string   "note"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "teacher_id"
    t.integer  "university_id"
    t.integer  "staff_id"
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "school"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "sat_score",    limit: 65535
    t.string   "sat_province"
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "tagged_by"
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "status"
    t.string   "redirect_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teacher_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "university_id"
    t.string   "cell"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "university_id"
    t.string   "cell"
    t.string   "name"
    t.string   "duty"
    t.integer  "status"
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "city"
    t.string   "address"
    t.string   "website"
    t.string   "tel"
    t.text     "brief",      limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "logo"
    t.string   "province"
    t.integer  "hot",                      default: 0
  end

  create_table "user_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "cell",            limit: 50
    t.integer  "sex"
    t.string   "token",           limit: 50
    t.string   "identity_id",     limit: 50
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "identity_type"
    t.string   "union_id"
    t.datetime "subscribe_at"
    t.datetime "unsubscribe_at"
    t.boolean  "online_status"
    t.string   "openweb_openid"
    t.string   "mp_openid"
    t.string   "miniapp_openid"
    t.string   "nickname"
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.string   "headimgurl"
    t.string   "language"
    t.string   "name"
    t.integer  "last_message_id",            default: 0
  end

  create_table "wishcards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "user_id"
    t.text     "cities",        limit: 65535
    t.text     "universities",  limit: 65535
    t.text     "majors",        limit: 65535
    t.text     "introdution",   limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "count_of_like",               default: 0
    t.string   "nickname"
    t.string   "headimgurl"
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

  create_table "yx_zys", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "yxmc", limit: 64, null: false, collation: "utf8_general_ci"
    t.string "yxdm", limit: 5,  null: false, collation: "utf8_general_ci"
    t.string "zymc", limit: 64, null: false, collation: "utf8_general_ci"
    t.string "zydm", limit: 6,  null: false, collation: "utf8_general_ci"
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
