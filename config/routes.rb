Rails.application.routes.draw do

  # ---[Sessions]---
  get "login" => "sessions#new", as: :login # create login_path
  post   "login"  => "sessions#create"
  delete "logout" => "sessions#destroy", as: :logout # create logout_path

  resources :users

  resources :user_messages

  resources :likes, only: [:create, :destroy]

  get '/' => 'home#top'
  get '/about' => 'home#about'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#top"

  mount MissionControl::Jobs::Engine, at: "/jobs"
end
