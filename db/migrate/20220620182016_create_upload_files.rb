class CreateUploadFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :upload_files do |t|
      t.text :file
      t.timestamps
    end
  end
end
