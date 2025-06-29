Rails.application.routes.draw do
  get "blog", to: "blog#index"
  get "blog/posts/:id", to: "blog#show", as: :blog_post

  get "about", to: "home#index"
  get "coach", to: "coach#index"

  get "/up", to: proc { [200, {}, ["OK"]] }

  root "home#index"
end
