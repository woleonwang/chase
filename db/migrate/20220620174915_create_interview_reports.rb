class CreateInterviewReports < ActiveRecord::Migration[5.1]
  def change
    create_table :interview_reports do |t|
      t.references :user, index: true
      t.string :share_token
      t.text :skill_summary
      t.string :skill_interviewer
      t.text :ability_detail
      t.text :ability_summary
      t.string :ability_interviewer
      t.text :live_coding_video
      t.text :live_coding_skills
      t.datetime :live_coding_created_at
      t.text :soft_skills
      t.text :track_records

      t.timestamps
    end
  end
end
