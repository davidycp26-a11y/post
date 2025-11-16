Rails.application.routes.draw do
  get "posts/index" => "user_messages#index"
  get "posts/new" => "user_messages#new"
  post "posts/create" => "user_messages#create"
  get "posts/:id" => "user_messages#show"
 
  resources :messages
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/' => 'home#top'
  get '/about' => 'home#about'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#top"

  # root "posts#index"
  mount MissionControl::Jobs::Engine, at: "/jobs"
end
