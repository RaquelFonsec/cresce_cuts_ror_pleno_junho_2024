
Rails.application.routes.draw do

  namespace :api do
    resources :products, only: [:index]
  end

 
  resources :products, only: [:index] do
    collection do
      get 'index_api'
    end
  end

  resources :campaigns do
    resources :discounts, only: [:new, :create, :update, :destroy]
    member do
      get 'discount_history'
      get 'revert_version'
    end
  end

  devise_for :users

  root to: 'pages#home'
end
