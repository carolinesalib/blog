Rails.application.routes.draw do
  get "blog", to: "blog#index"
  get "blog/:id", to: "blog#show"
  get "about", to: "home#index"

  root "home#index"
end
