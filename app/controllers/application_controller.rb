class ApplicationController < ActionController::Base
  class NotAuthorized < StandardError; end

  before_action :require_user

  # protect_from_forgery with: :exception
  rescue_from "NotAuthorized" do |exception|
    head 401
  end

  def current_user
    @current_user
  end

  private

  def require_user
    user_id = JWT.decode(request.headers["Authorization"], "woleon", "HS256")[0]["id"] rescue nil
    if !(user_id.present? && @current_user = User.find_by(id: user_id))
      raise NotAuthorized.new("token is invalid")
    end
  end
end
