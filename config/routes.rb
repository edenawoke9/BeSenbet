Rails.application.routes.draw do
  # Devise user routes, with custom controller for sessions
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  # Health check route for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check
  resources :products do 
    resources :reviews
  end


  # Define the root path route ("/")
  root "products#index"
end
