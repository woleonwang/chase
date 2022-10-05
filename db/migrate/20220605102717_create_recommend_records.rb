class CreateRecommendRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :recommend_records do |t|
      t.references :user, index: true
      t.references :recommend_user, index: true
      t.references :recommend_token, index: true
      t.timestamps
    end
  end
end
