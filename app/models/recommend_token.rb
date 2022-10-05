class RecommendToken < ApplicationRecord
  has_many :recommend_records
  belongs_to :user
end
