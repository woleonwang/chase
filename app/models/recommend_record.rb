class RecommendRecord < ApplicationRecord
  belongs_to :user
  belongs_to :recommend_token
  belongs_to :recommend_user, class_name: "User"
end
