class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate
    return if current_user
    redirect_to root_path, alert: "ログインしてください"
  end
end
