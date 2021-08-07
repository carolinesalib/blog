Rails.application.routes.draw do
  get "blog", to: "blog#index"
  get "about", to: "home#index"

  root "home#index"
end
