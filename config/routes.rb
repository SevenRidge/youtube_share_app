Rails.application.routes.draw do

  root to: 'tops#index'
  
  resources :posts
  resources :users
  resources :likes, only: [:create, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
