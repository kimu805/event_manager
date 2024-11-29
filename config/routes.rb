Rails.application.routes.draw do
  root to: "welcome#index"
  get "/auth/:provider/callback", to: "sessions#github"
  get "/auth/failure", to: redirect("/")
  delete "/logout", to: "sessions#destroy"
end
