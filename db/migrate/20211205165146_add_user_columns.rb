class AddUserColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :company, :string
    add_column :users, :experience, :string
    add_column :users, :total_career_visible, :boolean
    add_column :users, :recent_placements_visible, :boolean
    add_column :users, :candidate_pool_visible, :boolean
    add_column :users, :current_jobs_visible, :boolean
  end
end
