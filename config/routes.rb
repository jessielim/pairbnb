require 'sidekiq/web'
Rails.application.routes.draw do
  
mount Sidekiq::Web => '/sidekiq'
  resources :properties
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :listings do
  get 'page/:page', action: :index, on: :collection
  end

  root to: 'home#index'
  get '/' => "home#index", as: "home"
  
  get '/about_us' => "home#about", as: "about"

  get '/profile/edit' => "users#edit", as: "profile_edit"

  post '/profile/edit' => "users#update"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get '/listings' => "listings#index", as: "listing_index"

  get '/listings/new' => "listings#new", as: "listing_new"

  post '/listings/new' => "listings#create"

  get '/listings/:id' => "listings#show", as: "listing_id"

  get '/listings/:id/edit' => "listings#edit", as: "listing_edit"

  post '/listings/:id/edit' => "listings#update"

  get '/listings/:id/reservations/new' => "reservations#new", as: "reservation_new"

  post '/listings/:id/reservations/new' => "reservations#create"

  get '/reservations' => "reservations#show", as: "reservation_show"

  get 'welcome/index'

  get 'braintree/:id' => "braintree#new" 
  
  post 'braintree/checkout'

end