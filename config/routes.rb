Rails.application.routes.draw do
  root to: "welcome#index"
  
  # login/logout
  get "/auth/:provider/callback", to: "sessions#github"
  get "/auth/failure", to: redirect("/")
  delete "/logout", to: "sessions#destroy"

  resources :events
end
