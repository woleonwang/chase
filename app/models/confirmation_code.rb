# encoding: utf-8
class ConfirmationCode < ApplicationRecord
  enumerize :event_type, in: [
                           "sign_up",
                           "sign_in",
                         ]

  after_create :send_msg

  def send_msg
    url = "http://39.101.172.97:7862/sms?action=send"
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    payload = {
      "account" => "206131",
      "password" => "m4Tk5f",
      "mobile" => self.phone.to_s,
      "content" => "【Landd】验证码#{self.code}",
      "extno" => "1069061",
    }
    url = "#{url}&#{payload.to_query}"
    resp = RestClient.post(url, {}).body
  end
end
