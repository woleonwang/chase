class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  after_create :confirm_email
  after_create :create_recommend_token

  has_one :profile
  has_many :recommend_tokens
  has_many :recommend_records
  has_many :interview_reports

  enumerize :role, in: [
                     "developer",
                     "recommend",
                   ], default: "developer"

  def create_recommend_token
    # 以后考虑重复情况
    token = SecureRandom.hex
    self.recommend_tokens.create(token: "#{self.phone.last(4)}-#{token}")
  end

  private

  def confirm_email
    self.confirm
    self.create_profile
  end
end
