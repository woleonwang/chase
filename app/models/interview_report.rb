class InterviewReport < ApplicationRecord
  belongs_to :user

  before_create :set_share_token

  def set_share_token
    self.share_token = SecureRandom.uuid
  end

  def share_token_url
    "https://landd.co/interview_reports/#{self.share_token}"
  end
end
