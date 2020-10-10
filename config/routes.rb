Rails.application.routes.draw do
  get 'users/show'
  get 'users/new'
  root "static_pages#home"
  get "home", to: "static_pages#home"
  get "about", to: "static_pages#about"
  resources :users
end