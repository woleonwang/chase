class AddRecruiterBasic < ActiveRecord::Migration[5.1]
  def change
    add_column :recruiters, :phone, :string, null: false
  end
end
