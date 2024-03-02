Rails.application.routes.draw do
  get "blog", to: "blog#index"
  get "blog/posts/:id", to: "blog#show", as: :blog_post

  get "about", to: "home#index"
  get "coach", to: "coach#index"

  root "home#index"
end
