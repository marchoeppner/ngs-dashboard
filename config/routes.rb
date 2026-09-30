Rails.application.routes.draw do
  get "pages/dashboard"
  get "pages/settings"
  resources :xref_job_libraries

  namespace :settings do
    resource :password, only: [ :show, :update ]
  end

  resources :jobs do
    resources :libraries
    resources :users
  end

  resources :job_schedulers
  resources :pipelines
  resources :libraries do
    resources :jobs
  end

  resources :projects
  resources :runs do
    collection do
      get :register
    end
    member do
      post :create_bulk
    end
  end
  resources :platforms
  resource :session
  resources :passwords, param: :token
  resource :sign_up

  get "dashboard", to: "pages#dashboard"
  get "settings", to: "pages#settings"

  namespace :api do
    namespace :v1 do
      resources :jobs, only: [ :index, :show, :update ]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#dashboard"
end
