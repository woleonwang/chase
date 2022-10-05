class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.references :profile, index: true
      t.string :name
      t.integer :years
      t.string :level
      t.timestamps
    end
  end
end
