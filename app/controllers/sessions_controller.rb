class SessionsController < ApplicationController

  def github
    user_info = request.env["omniauth.auth"]
    Rails.logger.info "GitHub user info: #{ user_info.inspect }"

    user = User.find_or_initialize_by(provider: user_info["provider"], uid: user_info["uid"])
    user.name = user_info["info"]["name"]
    user.image_url = user_info["info"]["image"]
    

    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました！"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました！"
  end

end