# encoding: utf-8
class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :english_level, comment: "英语水平"
      t.string :name, comment: "姓名"
      t.string :name_en, comment: "英文姓名"
      t.string :avatar, comment: "头像"
      t.string :country, comment: "居住国家"
      t.string :phone, comment: "手机"
      t.string :self_intro, comment: "自我介绍"
      t.string :self_intro_en, comment: "英文自我介绍"
      t.string :linkedin_url, comment: "领英链接"
      t.string :github_url, comment: "github链接"
      t.string :attachment, comment: "简历附件"
      t.string :remote_work_status, comment: "对远程工作的求职状态"
      t.string :interested_remote_work, comment: "感兴趣的工作类型"
      t.integer :worktime_per_week, comment: "每周工作时长"
      t.string :remote_work_location, comment: "可接受的工作地点"
      t.string :attitude_for_night_work, comment: "对晚上工作的态度"
      t.string :lastest_of_night_work, comment: "最晚工作时间"
      t.string :current_position, comment: "当前职位"
      t.integer :development_experience, comment: "开发工作经验"
      t.integer :remote_work_experience, comment: "远程工作经验"
      t.string :attitude_for_web_three, comment: "是否愿意加入 web3"
      t.string :experience_for_web_three, comment: "是否有 web3 经验"
      t.integer :basic_salary, comment: "基本薪资"
      t.integer :bonus_min, comment: "奖金最小值"
      t.integer :bonus_max, comment: "奖金最大值"
      t.string :stock, comment: "股票"
      t.string :other_salary, comment: "其他收入"
      t.integer :expect_salary_per_hour, comment: "期望薪资（按小时计）"
      t.integer :expect_salary_per_year, comment: "期望薪资（按年计）"

      t.timestamps
    end
  end
end
