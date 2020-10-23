Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "home", to: "static_pages#home"
  get "about", to: "static_pages#about"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only:[:create, :destroy, :edit, :update]
  resources :account_activations, only:[:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :events
  resources :relationships, only: [:create, :destroy]
end