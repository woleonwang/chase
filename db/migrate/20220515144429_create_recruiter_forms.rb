class CreateRecruiterForms < ActiveRecord::Migration[5.1]
  def change
    create_table :recruiter_forms do |t|
      t.string :company
      t.string :email
      t.string :headcount
      t.string :hire_positions
      t.string :name
      t.string :phone
      t.string :position
      t.string :staff_count
      t.string :website
      t.string :wechat
      t.timestamps
    end
  end
end
