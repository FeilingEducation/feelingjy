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

ActiveRecord::Schema.define(version: 20180609120011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

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
    t.string "open_tok_session_id"
    t.index ["instructor_id"], name: "index_consult_transactions_on_instructor_id"
    t.index ["student_id"], name: "index_consult_transactions_on_student_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name_en"
    t.string "name_cn"
    t.text "details_en"
    t.text "details_cn"
    t.datetime "submission_deadline"
    t.integer "ranking"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "slug"
    t.index ["university_id"], name: "index_departments_on_university_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
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
    t.string "specialization", array: true
    t.string "degree_completed"
    t.integer "consulting_tutor"
    t.integer "brainstorming_tutor"
    t.integer "writing_tutor"
    t.integer "visa_consultant"
    t.boolean "helped_before"
    t.string "country"
    t.string "state"
    t.string "city"
    t.text "description"
    t.boolean "share_edited_files"
    t.boolean "share_info"
    t.boolean "meet_in_person"
    t.boolean "answer_free"
    t.boolean "personal_questions"
    t.boolean "accomplishment"
    t.boolean "free_time"
    t.boolean "how_to_write"
    t.boolean "nervous"
    t.boolean "care_cooperation"
    t.boolean "ensure_accurate_time"
    t.integer "max_std_count"
    t.integer "tutor_before"
    t.integer "min_work_days", default: 2
    t.integer "max_work_days", default: 2
    t.integer "advance_notify"
    t.integer "reserve_advance"
    t.boolean "recommended_price", default: true
    t.integer "min_price"
    t.integer "max_price"
    t.integer "fix_price"
    t.string "work_frequency"
    t.boolean "first_std_discount", default: true
    t.integer "best_applying_at"
    t.integer "number_institutes_applied"
    t.integer "number_institutes_admitted"
    t.boolean "share_resume", default: false
    t.boolean "share_application_essay", default: false
    t.boolean "share_offer_letter", default: false
    t.boolean "share_gpa", default: false
    t.boolean "share_gre_score", default: false
    t.boolean "share_paper", default: false
    t.boolean "share_course_essay", default: false
    t.string "page_name"
    t.integer "uni_accepted", array: true
    t.boolean "is_graduate", default: true
    t.integer "consult_min_price"
    t.integer "consult_max_price"
    t.integer "consult_fix_price"
    t.integer "brainstorm_min_price"
    t.integer "brainstorm_max_price"
    t.integer "brainstorm_fix_price"
    t.integer "essay_min_price"
    t.integer "essay_max_price"
    t.integer "essay_fix_price"
    t.integer "visa_min_price"
    t.integer "visa_max_price"
    t.integer "visa_fix_price"
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
    t.jsonb "alipay_response"
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "pictureable_type"
    t.bigint "pictureable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "uuid"
    t.index ["pictureable_type", "pictureable_id"], name: "index_pictures_on_pictureable_type_and_pictureable_id"
  end

  create_table "private_policies", force: :cascade do |t|
    t.integer "instructor_id", null: false
    t.text "content"
    t.boolean "pending", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_private_policies_on_instructor_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "service_communication_rating"
    t.integer "attitude_rating"
    t.integer "efficiency_rating"
    t.integer "authenticity_rating"
    t.integer "cost_effectiveness_rating"
    t.integer "user_id"
    t.integer "reviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "review_text"
    t.integer "consult_transaction_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name_en"
    t.string "name_cn"
    t.string "logo_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description_en"
    t.text "description_cn"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.bigint "picture_id"
    t.string "uuid"
    t.string "slug"
    t.index ["picture_id"], name: "index_universities_on_picture_id"
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

  create_table "user_wallet_activities", force: :cascade do |t|
    t.bigint "user_wallet_id"
    t.bigint "consult_transaction_id"
    t.bigint "payment_id"
    t.integer "txn_type"
    t.integer "txn_status"
    t.datetime "withdrawal_requested_at"
    t.datetime "withdrawal_processed_at"
    t.datetime "withdrawal_completed_at"
    t.text "withdrawal_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "amount"
    t.index ["consult_transaction_id"], name: "index_user_wallet_activities_on_consult_transaction_id"
    t.index ["payment_id"], name: "index_user_wallet_activities_on_payment_id"
    t.index ["user_wallet_id"], name: "index_user_wallet_activities_on_user_wallet_id"
  end

  create_table "user_wallets", force: :cascade do |t|
    t.bigint "user_id"
    t.float "amount_earned"
    t.float "amount_withdrawn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wallets_on_user_id"
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

  add_foreign_key "departments", "universities"
  add_foreign_key "universities", "pictures"
  add_foreign_key "user_wallet_activities", "consult_transactions"
  add_foreign_key "user_wallet_activities", "payments"
  add_foreign_key "user_wallet_activities", "user_wallets"
  add_foreign_key "user_wallets", "users"
end
