# encoding: utf-8
class RecruitersController < ApplicationController
  before_action :require_recruiter
  skip_before_action :require_recruiter, only: [
                                           :send_verification_code,
                                           :sign_up,
                                           :sign_in_by_code,
                                         ]

  def show
    render json: Recruiter.find(params[:id])
  end

  def send_verification_code
    puts 2
    phone = params[:phone]
    type = params[:type]
    valid = true
    error_code = 0

    if !phone.match(/[0-9]{11}/).present?
      valid = false
      error_code = 100001
    elsif type === "sign_in" && !Recruiter.exists?(phone: phone)
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
    if !ConfirmationCode.exists?(phone: phone, code: code, event_type: "sign_up")
      render json: {
        code: 100001,
        message: "验证码不正确",
      }
    elsif Recruiter.exists?(phone: phone)
      render json: {
        code: 100002,
        message: "手机已被注册",
      }
    else
      recruiter = Recruiter.new(phone: phone, email: "#{phone}@landd.co", password: phone)
      recruiter.skip_confirmation_notification!
      if recruiter.save
        render json: {
          code: 0,
          data: {
            token: JWT.encode({ id: recruiter.id }, "woleon", "HS256"),
          },
        }
      else
        render json: {
          code: 100422,
          errors: recruiter.errors,
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
      recruiter = recruiter.find_by(phone: phone)
      if recruiter.nil?
        render json: {
          code: 100002,
          message: "手机不存在",
        }
      else
        render json: {
          code: 0,
          data: {
            token: JWT.encode({ id: recruiter.id }, "woleon", "HS256"),
          },
        }
      end
    end
  end
end
