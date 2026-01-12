Rails.application.routes.draw do
  # Locale scope for all application routes
  scope "(:locale)", locale: /en|ja/ do
    # ---[Sessions]---
    get "login" => "sessions#new", as: :login # create login_path
    post   "login"  => "sessions#create"
    delete "logout" => "sessions#destroy", as: :logout # create logout_path

    resources :users
    get 'users/:id/likes' => 'users#likes', as: :user_likes # create user_likes_path

    resources :user_messages

    resources :likes, only: [:create, :destroy]

    resources :comments, only: [:create, :edit, :update, :destroy]

    get '/about' => 'home#about'

    # Defines the root path route ("/")
    root "home#top"
  end

  # Health check outside locale scope
  get "up" => "rails/health#show", as: :rails_health_check

  # Mission Control outside locale scope
  mount MissionControl::Jobs::Engine, at: "/jobs"
end
