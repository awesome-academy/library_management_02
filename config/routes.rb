Rails.application.routes.draw do
  get "carts/show"
  default_url_options host: "localhost:3000"
  root "books#index"
  get "users/show"
  get "users/new"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  delete "logout", to: "sessions#destroy"

  resources :users, :authors, :publishers, :books, :categories, :borrows
  resources :borrow_details, only: [:create, :update, :destroy]
  resource :cart, only: [:show]

  namespace :admin do
    resources :books
    resources :borrows do
      member do
        get "accept_request"
        patch "deny_request"
      end
    end
    resources :borrow_details, only: [:create, :update, :destroy]
  end
end
