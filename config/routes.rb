Rails.application.routes.draw do
  root to: 'pages#front'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  resources :users, only: [:create, :show]
  resources :cart_items, only: [:create, :destroy, :index]
  resources :orders, only: [:index, :create, :show]

  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :destroy]
  end

  namespace :admin do
    resources :products, only: [:new, :create, :destroy]
  end
end
