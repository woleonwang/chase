class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
      t.references :profile, index: true
      t.string :locale
      t.string :degree
      t.string :school
      t.date :from
      t.date :to
      t.timestamps
    end
  end
end
