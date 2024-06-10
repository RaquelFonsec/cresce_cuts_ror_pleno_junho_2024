Rails.application.routes.draw do
  # Routes for campaigns and their discounts

  get '/api/products', to: 'products#index_api'
 
  resources :campaigns do
    resources :discounts, only: [:new, :create]
    get 'discount_history', to: 'campaigns#discount_history', on: :member
    member do
      get :revert_version
    end
  end

  # Route for user authentication with Devise
  devise_for :users

  # Root route
  root to: 'pages#home'
end