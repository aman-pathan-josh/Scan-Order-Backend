Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    invitations: "users/invitations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  namespace :super_admin do
    get "dashboard", to: "dashboard#index"
    resources :restaurants, only: [ :index ]
    resources :users
    # resources :menu_items, only: [ :index ]
    # resources :orders, only: [ :index ]
    # resources :reviews, only: [ :index ]
  end

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :restaurants do
      resources :menu_items do
        resources :reviews
      end
      resources :restaurant_tables do
        member do
          post :generate_qr
        end
      end
      resources :orders
    end
  end

  namespace :v1, defaults: { format: :json } do
    resources :restaurants do
      resources :orders
    end
    resources :restaurant_tables
    resources :menu_items
    resources :reviews
    resources :order_carts
    post "/signin", to: "auth#signin"
    post "/signup", to: "auth#signup"
  end

  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  mount ActiveStorage::Engine => "/rails/active_storage"

  get "*path", to: redirect("/"), constraints: lambda { |req|
    !req.path.start_with?("/rails/active_storage")
  }
end
