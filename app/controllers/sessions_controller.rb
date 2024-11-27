class SessionsController < ApplicationController

  def github
    user_info = request.env["omniauth.auth"]

    user = User.find_or_create_by(provider: user_info["provider"], uid: user_info["uid"]) do |u|
      u.name = user_info["info"]["name"]
      u.email = user_info["info"]["email"]
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました！"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました！"
  end

end