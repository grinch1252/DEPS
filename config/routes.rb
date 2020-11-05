Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "home", to: "static_pages#home"
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/graph",  to: "users#graph"
  get    "/login", to: "sessions#new"
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    get :search, on: :collection
    member do
      get :following, :followers
    end
  end
  resources :microposts, only:[:create, :destroy, :edit, :update]
  resources :account_activations, only:[:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :events
  resources :subjects
  resources :relationships, only: [:create, :destroy]
  resources :likes, only:[:create, :destroy]
end