Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :posts
  resources :users
  resources :likes, only: [:create, :destroy]

end
