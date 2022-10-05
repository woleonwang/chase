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

ActiveRecord::Schema.define(version: 20220626103448) do

  create_table "bc_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "name"
    t.integer "years"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_bc_skills_on_profile_id"
  end

  create_table "certifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "locale"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_certifications_on_profile_id"
  end

  create_table "confirmation_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "phone"
    t.string "code"
    t.string "event_type"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "locale"
    t.string "degree"
    t.string "school"
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_educations_on_profile_id"
  end

  create_table "industries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "locale"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_industries_on_profile_id"
  end

  create_table "interview_reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.string "share_token"
    t.text "skill_summary"
    t.string "skill_interviewer"
    t.text "ability_detail"
    t.string "ability_interviewer"
    t.text "live_coding_video"
    t.text "soft_skills"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "ability_summary"
    t.text "live_coding_skills"
    t.datetime "live_coding_created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "track_records"
    t.index ["user_id"], name: "index_interview_reports_on_user_id"
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.string "english_level", comment: "英语水平"
    t.string "name", comment: "姓名"
    t.string "name_en", comment: "英文姓名"
    t.string "avatar", comment: "头像"
    t.string "country", comment: "居住国家"
    t.string "phone", comment: "手机"
    t.string "self_intro", comment: "自我介绍"
    t.string "self_intro_en", comment: "英文自我介绍"
    t.string "linkedin_url", comment: "领英链接"
    t.string "github_url", comment: "github链接"
    t.string "attachment", comment: "简历附件"
    t.string "remote_work_status", comment: "对远程工作的求职状态"
    t.string "interested_remote_work", comment: "感兴趣的工作类型"
    t.integer "worktime_per_week", comment: "每周工作时长"
    t.string "remote_work_location", comment: "可接受的工作地点"
    t.string "attitude_for_night_work", comment: "对晚上工作的态度"
    t.string "lastest_of_night_work", comment: "最晚工作时间"
    t.string "current_position", comment: "当前职位"
    t.integer "development_experience", comment: "开发工作经验"
    t.integer "remote_work_experience", comment: "远程工作经验"
    t.string "attitude_for_web_three", comment: "是否愿意加入 web3"
    t.string "experience_for_web_three", comment: "是否有 web3 经验"
    t.integer "basic_salary", comment: "基本薪资"
    t.integer "bonus_min", comment: "奖金最小值"
    t.integer "bonus_max", comment: "奖金最大值"
    t.string "stock", comment: "股票"
    t.string "other_salary", comment: "其他收入"
    t.integer "expect_salary_per_hour", comment: "期望薪资（按小时计）"
    t.integer "expect_salary_per_year", comment: "期望薪资（按年计）"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "reason_for_web_three"
    t.string "understand_web_three"
    t.text "steps"
    t.datetime "xxx", default: -> { "CURRENT_TIMESTAMP" }
    t.string "weixin"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "locale"
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "skills"
    t.index ["profile_id"], name: "index_projects_on_profile_id"
  end

  create_table "recommend_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.bigint "recommend_user_id"
    t.bigint "recommend_token_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recommend_token_id"], name: "index_recommend_records_on_recommend_token_id"
    t.index ["recommend_user_id"], name: "index_recommend_records_on_recommend_user_id"
    t.index ["user_id"], name: "index_recommend_records_on_user_id"
  end

  create_table "recommend_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "user_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_recommend_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_recommend_tokens_on_user_id"
  end

  create_table "recruiter_forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "company"
    t.string "email"
    t.string "headcount"
    t.string "hire_positions"
    t.string "name"
    t.string "phone"
    t.string "position"
    t.string "staff_count"
    t.string "website"
    t.string "wechat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "name"
    t.integer "years"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_skills_on_profile_id"
  end

  create_table "upload_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.text "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname"
    t.string "avatar"
    t.string "intro"
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
    t.string "company"
    t.string "experience"
    t.boolean "total_career_visible"
    t.boolean "recent_placements_visible"
    t.boolean "candidate_pool_visible"
    t.boolean "current_jobs_visible"
    t.string "phone", null: false
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.bigint "profile_id"
    t.string "locale"
    t.string "position"
    t.string "company"
    t.date "from"
    t.date "to"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_works_on_profile_id"
  end

end
