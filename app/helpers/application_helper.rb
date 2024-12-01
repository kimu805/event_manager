module ApplicationHelper
  def url_for_github(user)
    "https://github/#{ user.name }"
  end
end
