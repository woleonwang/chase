class CreateBcSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :bc_skills do |t|
      t.references :profile, index: true
      t.string :name
      t.integer :years
      t.string :level
      t.timestamps
    end
  end
end
