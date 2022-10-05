class UsersMailer < ApplicationMailer
  def test_email
    mail({
      to: "305463144@qq.com",
      subject: "Please confirm your Talibre email address",
    })
  end

  def confirm_email(email, token)
    @token = token
    mail({
      to: email,
      subject: "Please confirm your Trovve email address",
    })
  end
end
