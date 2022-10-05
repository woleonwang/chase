class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :profile, index: true
      t.string :locale
      t.string :name
      t.text :description
      t.string :url
      t.timestamps
    end
  end
end
