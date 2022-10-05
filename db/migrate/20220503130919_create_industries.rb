class CreateIndustries < ActiveRecord::Migration[5.1]
  def change
    create_table :industries do |t|
      t.references :profile, index: true
      t.string :locale
      t.string :name
      t.timestamps
    end
  end
end
