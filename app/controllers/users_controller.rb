# encoding: utf-8
class UsersController < ApplicationController
  before_action :require_user

  skip_before_action :require_user, only: [
                                      :send_verification_code,
                                      :sign_up,
                                      :sign_in_by_code,
                                    ]

  def show
    render json: User.find(params[:id])
  end

  def send_verification_code
    phone = params[:phone]
    type = params[:type]
    valid = true
    error_code = 0

    if !phone.match(/[0-9]{11}/).present?
      valid = false
      error_code = 100001
    elsif type === "sign_in" && !User.exists?(phone: phone)
      valid = false
      error_code = 100002
    end

    if !valid
      render json: {
        code: error_code,
      }
    elsif ConfirmationCode.create(phone: phone, event_type: type, code: 6.times.map { |x| (rand() * 10).floor }.join(""))
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100001,
        message: "短信发送失败",
      }
    end
  end

  def sign_up
    phone = params[:phone]
    code = params[:code]
    token = params[:token]
    role = params[:role]
    if !ConfirmationCode.exists?(phone: phone, code: code, event_type: "sign_up")
      render json: {
        code: 100001,
        message: "验证码不正确",
      }
    elsif User.exists?(phone: phone)
      render json: {
        code: 100002,
        message: "手机已被注册",
      }
    elsif token.present? && (recommend_token = RecommendToken.find_by(token: params[:token])).blank?
      render json: {
        code: 100003,
        message: "邀请码错误",
      }
    else
      user = User.new(phone: phone, email: "#{phone}@landd.co", password: phone, role: role)
      user.skip_confirmation_notification!
      if user.save
        if recommend_token.present?
          recommend_token.recommend_records.create!(user_id: recommend_token.user_id, recommend_user_id: user.id)
        end
        render json: {
          code: 0,
          data: {
            token: JWT.encode({ id: user.id }, "woleon", "HS256"),
          },
        }
      else
        render json: {
          code: 100422,
          errors: user.errors,
        }
      end
    end
  end

  def sign_in_by_code
    phone = params[:phone]
    code = params[:code]
    if !ConfirmationCode.exists?(phone: phone, code: code, event_type: "sign_in")
      render json: {
        code: 100001,
        message: "验证码不正确",
      }
    else
      user = User.find_by(phone: phone)
      if user.nil?
        render json: {
          code: 100002,
          message: "手机不存在",
        }
      else
        render json: {
          code: 0,
          data: {
            token: JWT.encode({ id: user.id }, "woleon", "HS256"),
          },
        }
      end
    end
  end

  def recommend_token
    if current_user.recommend_tokens.count == 0
      current_user.create_recommend_token
    end

    render json: {
      code: 0,
      data: {
        token: current_user.recommend_tokens.first&.token,
      },
    }
  end

  def recommend_records
    render json: {
      code: 0,
      data: {
        recommend_records: current_user.recommend_records.preload(recommend_user: :profile).map do |record|
          {
            id: record.id,
            name: record.recommend_user.profile.name,
            status: "not_board",
            award: 0,
          }
        end,
      },
    }
  end
end
