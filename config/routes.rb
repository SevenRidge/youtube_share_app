Rails.application.routes.draw do

  root to: 'tops#index'
  
  resources :posts
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :likes, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/tops/guest_sign_in', to: 'sessions#new_guest'

end
