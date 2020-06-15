Rails.application.routes.draw do

  get 'howtouse/index'
  # root
  root to: 'tops#index'

  # resources化
  resources :likes, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  # sessionsコントローラー
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # statisticsコントローラー
  get '/statistics', to: 'statistics#index'

  # ゲストログイン用
  post '/tops/guest_sign_in', to: 'sessions#new_guest'

  # howtouse用
  get '/howtouse', to: 'howtouse#index'

  resources :posts
  resources :users do
    member do
      get :followings, :followers
    end
  end
end
