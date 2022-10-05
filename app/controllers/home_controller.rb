class HomeController < ApplicationController
  skip_before_action :require_user, only: [:helloworld]

  def helloworld
    render plain: "hello world", status: 500
  end

  def check_admin_token
    render json: {
      code: params["admin_token"] === "59b8902fbce6353575d8c3626f36b18f" ? 0 : 100001,
    }
  end
end
