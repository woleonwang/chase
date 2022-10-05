class CreateCertifications < ActiveRecord::Migration[5.1]
  def change
    create_table :certifications do |t|
      t.references :profile, index: true
      t.string :locale
      t.string :description
      t.timestamps
    end
  end
end
