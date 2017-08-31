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

ActiveRecord::Schema.define(version: 20170831045754) do

  create_table "instructor_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.boolean "is_early_consult", default: false, null: false
    t.boolean "is_brainstorm_consult", default: false, null: false
    t.boolean "is_essay_consult", default: false, null: false
    t.boolean "is_visa_consult", default: false, null: false
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
  end

  create_table "user_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "current_city", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "is_instructor", default: false, null: false
    t.integer "gender", default: 0, null: false
    t.string "home_town", default: "", null: false
    t.string "current_institute", default: "", null: false
    t.string "highest_education", default: "", null: false
    t.string "major", default: "", null: false
    t.string "other_majors", default: "", null: false
    t.integer "years_in_program"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
