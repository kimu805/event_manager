class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :github

  def github
    user_info = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(provider: user_info["provider"], uid: user_info["uid"])
    user.name = user_info["info"]["name"]
    user.image_url = user_info["info"]["image"]
    user.email = user_info["info"]["email"]
    binding.pry
    user.save!

    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました！"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました！"
  end

end