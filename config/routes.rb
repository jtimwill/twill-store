Rails.application.routes.draw do
  root to: 'pages#front'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  get 'cart', to: 'cart_items#index'
  post 'update_cart', to: 'cart_items#update_cart'

  resources :users, only: [:create, :show]
  resources :cart_items, only: [:create, :destroy]
  resources :orders, only: [:new, :create, :show]
  resources :categories, only: [:show]
  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :destroy]
  end

  namespace :admin do
    resources :products, only: [:new, :create, :destroy]
  end
end
