Rails.application.routes.draw do
  
  root 'static#home'

  resources :trucks, except: [:new] do ### BLOG POST
    resources :icecreams
    resources :orders, only: [:new, :create, :index]
  end

  # New Truck
  get 'truck_signup', to: 'trucks#new'

  # New Customer
  get 'signup', to: 'customers#new'
  
  # Sessions
  get 'truck_login', to: "sessions#truck_login"
  post 'truck_login', to: 'sessions#create'
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :customers, except: [:new] do
    resources :trucks, only: [:index]
    # Customer Wallet
    get 'wallet', to: 'customers#wallet'
    patch 'wallet', to: 'customers#update_wallet'
  end

  resources :orders, only: [:index]

  # Oauth Facebook
  get '/auth/facebook/callback', to: 'sessions#create_via_fb'

end
