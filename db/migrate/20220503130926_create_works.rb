class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.references :profile, index: true
      t.string :locale
      t.string :position
      t.string :company
      t.date :from
      t.date :to
      t.text :description
      t.timestamps
    end
  end
end
