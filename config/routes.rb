Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#show"

  resources :time_entries, only: [:index, :new, :create, :destroy]

  get 'sign_in', action: :new, controller: :sessions
  get 'sign_in_callback', action: :create, controller: :sessions
  get 'sign_out', action: :destroy, controller: :sessions
end
