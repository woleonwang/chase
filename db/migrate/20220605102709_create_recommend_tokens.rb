class CreateRecommendTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :recommend_tokens do |t|
      t.references :user, index: true
      t.string :token, index: { unique: true }

      t.timestamps
    end
  end
end
