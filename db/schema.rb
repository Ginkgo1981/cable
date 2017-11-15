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

ActiveRecord::Schema.define(version: 20171115141312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "attachings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "attachable_id"
    t.string   "attachable_type"
    t.uuid     "attachment_id"
    t.string   "attachment_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "beans", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "bean_family_id"
    t.string   "bean_family_type"
    t.string   "dsin"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "bookmarkings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "bookmarkable_id"
    t.string   "bookmarkable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cells", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "cell"
    t.string   "code"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.integer  "hot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "company_name"
    t.string   "company_city"
    t.string   "company_category"
    t.string   "company_kind"
    t.string   "company_scale"
    t.string   "company_address"
    t.string   "company_zip"
    t.string   "company_website"
    t.text     "company_description"
    t.string   "company_tel"
    t.string   "company_email"
    t.string   "company_origin_url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "company_hr_name"
    t.string   "company_hr_mobile"
  end

  create_table "educations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "resume_id"
    t.string   "university"
    t.string   "major"
    t.string   "degree"
    t.text     "courses",                 array: true
    t.text     "images",                  array: true
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiences", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "resume_id"
    t.string   "title"
    t.text     "content"
    t.text     "images",                  array: true
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.uuid     "follower_id"
    t.uuid     "follower_type"
  end

  create_table "forms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "form_id"
    t.datetime "expired_at"
    t.integer  "status"
    t.string   "content"
    t.string   "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "group_no"
    t.uuid     "init_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "honors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "resume_id"
    t.string   "title"
    t.text     "content"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "images",                  array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hr_resumes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "hr_id"
    t.uuid     "resume_id"
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "human_resource_infos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "addr"
    t.string   "company"
    t.string   "department"
    t.string   "email"
    t.string   "name"
    t.string   "tel_cell"
    t.string   "tel_work"
    t.string   "title"
    t.string   "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "inviter_id"
    t.uuid     "invitee_id"
    t.uuid     "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_activities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_job_id"
    t.string   "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "job_interviews", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_job_id"
    t.string   "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "job_offers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_job_id"
    t.string   "note"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "jobs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "job_name"
    t.string   "job_salary_range"
    t.string   "job_recruitment_num"
    t.string   "job_type"
    t.string   "job_category"
    t.string   "job_city"
    t.string   "job_mini_education"
    t.string   "job_mini_experience"
    t.string   "job_language"
    t.text     "job_description"
    t.text     "job_majors",                                        array: true
    t.text     "job_tags",                                          array: true
    t.uuid     "company_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "job_origin_url"
    t.string   "job_origin_web_site_name"
    t.date     "job_published_at"
    t.integer  "approved",                 default: 0
    t.uuid     "approved_by"
    t.datetime "approved_at"
    t.integer  "rating",                   default: 0
  end

  create_table "likings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "comment"
  end

  create_table "major_hots", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.integer  "hot",        default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "majors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.uuid     "university_id"
    t.string   "goal"
    t.string   "claim"
    t.string   "course"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "message_bookmarkings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "message_id"
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_likings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "message_id"
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "type"
    t.datetime "expired_at"
    t.integer  "state"
    t.string   "img_url"
    t.uuid     "receiver_id"
    t.uuid     "sender_id"
    t.integer  "priority",    default: 0
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.string   "img_url"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qr_codes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "image"
    t.uuid     "codeable_id"
    t.string   "codeable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "red_packs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.integer  "amount"
    t.string   "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_benefits", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_categories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_experiences", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.uuid     "industry_id"
    t.string   "industry_name"
    t.string   "name"
    t.string   "content"
  end

  create_table "resume_dic_honor_tips", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.text     "tips",                    array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_industries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "q_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_interest_tags", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "intent"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resume_dic_skills", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resumes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "job_intention"
    t.string   "job_cities"
    t.string   "job_kind"
    t.string   "job_title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "university"
    t.string   "major"
    t.uuid     "user_id"
  end

  create_table "skills", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "resume_id"
    t.string   "title"
    t.string   "content"
    t.string   "category"
    t.text     "images",                  array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staffs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.text     "content"
    t.string   "coverage_img_url"
    t.uuid     "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "students", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "university"
    t.string   "major"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "taggable_id"
    t.string   "taggable_type"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.uuid     "tagged_by"
  end

  create_table "tasks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.string   "redirect_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "universities", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "city"
    t.string   "address"
    t.string   "website"
    t.string   "tel"
    t.text     "brief"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "logo"
    t.string   "province"
    t.integer  "hot",        default: 0
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "user_groups", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_jobs", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "resume_id"
    t.uuid     "job_id"
    t.uuid     "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "cell",                         limit: 50
    t.integer  "sex"
    t.string   "token",                        limit: 50
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "union_id"
    t.datetime "subscribe_at"
    t.datetime "unsubscribe_at"
    t.string   "device_info"
    t.boolean  "register_status"
    t.datetime "register_at"
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
    t.float    "latitude"
    t.float    "longitude"
    t.string   "type"
    t.string   "university"
    t.string   "major"
    t.string   "industry_tags",                                                    array: true
    t.string   "skill_tags",                                                       array: true
    t.integer  "notification_message_version",            default: 0
    t.integer  "role",                                    default: 0
    t.string   "avatar"
    t.integer  "hr_approved",                             default: 0
    t.uuid     "hr_approved_by"
    t.datetime "hr_approved_at"
    t.integer  "online_status",                           default: 0
  end

end
