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

ActiveRecord::Schema.define(version: 20171019171841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "file"
    t.string "md5"
    t.string "file_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
  end

  create_table "chat_lines", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_id"
    t.bigint "user_info_id"
    t.index ["chat_id"], name: "index_chat_lines_on_chat_id"
    t.index ["user_info_id"], name: "index_chat_lines_on_user_info_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "consult_transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consult_transaction_id"], name: "index_chats_on_consult_transaction_id"
  end

  create_table "consult_transactions", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.integer "student_id", null: false
    t.text "privacy_policy"
    t.integer "hourly_price"
    t.integer "status"
    t.integer "rating"
    t.text "feed_back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "service"
    t.date "scheduled_date"
    t.index ["instructor_id"], name: "index_consult_transactions_on_instructor_id"
    t.index ["student_id"], name: "index_consult_transactions_on_student_id"
  end

  create_table "instructor_infos", force: :cascade do |t|
    t.text "consult_experience"
    t.text "previous_applications"
    t.text "previous_offers"
    t.string "gpa"
    t.string "gre_score"
    t.text "suggestions_to_students"
    t.string "specialties"
    t.string "page_title"
    t.text "available_time_slots"
    t.text "busy_events"
    t.boolean "is_early_consult"
    t.boolean "is_brainstorm_consult"
    t.boolean "is_essay_consult"
    t.boolean "is_visa_consult"
    t.integer "consult_capacity_min"
    t.integer "consult_capacity_max"
    t.integer "consult_term_min"
    t.integer "consult_term_max"
    t.integer "consult_duration_min"
    t.integer "consult_duration_max"
    t.integer "consult_reserve_earliest"
    t.integer "consult_reserve_latest"
    t.string "consult_frequency"
    t.text "privacy_policy_template"
    t.string "pricing_strategy"
    t.integer "price_min"
    t.integer "price_max"
    t.integer "price_base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "avg_rating"
    t.string "url_linked_in"
    t.string "page_background"
    t.text "about_me"
    t.string "university"
    t.string "specialization"
    t.string "degree_completed"
    t.integer "consulting_tutor"
    t.integer "brainstorming_tutor"
    t.integer "writing_tutor"
    t.integer "visa_consultant"
    t.boolean "helped_before"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "payable_type"
    t.bigint "payable_id"
    t.integer "method"
    t.string "external_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id"
  end

  create_table "private_policies", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.text "content"
    t.boolean "pending", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_private_policies_on_instructor_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "current_city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.integer "gender"
    t.string "home_town"
    t.string "current_institute"
    t.string "highest_education"
    t.string "major"
    t.string "other_majors"
    t.integer "program_year"
    t.text "statement"
    t.string "phone_number"
    t.string "wechat_id"
    t.boolean "need_early_consult"
    t.boolean "need_essay_consult"
    t.boolean "need_brainstorm_consult"
    t.boolean "need_visa_consult"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "dob"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
