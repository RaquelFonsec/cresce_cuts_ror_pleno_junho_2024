Rails.application.routes.draw do
  # Routes for campaigns and their discounts
  resources :campaigns do
    resources :discounts, only: [:new, :create]
    member do
      get :revert_version
    end
  end

  # Route for user authentication with Devise
  devise_for :users

  # Root route
  root to: 'pages#home'
end