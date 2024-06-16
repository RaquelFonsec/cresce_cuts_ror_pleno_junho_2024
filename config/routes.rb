

Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    resources :products, only: [:index]
  end

  resources :products, only: [:index] do
    collection do
      get 'index_api'
    end
  end

  resources :campaigns do
    resources :discounts, only: [:create, :update, :destroy] do
      member do
        get 'history', to: 'discounts#history', as: 'history_discount'
        get 'diff', to: 'discounts#diff', as: 'diff_discount'
      end
    end

    member do
      get 'discount_history', to: 'campaigns#discount_history', as: 'discount_history'
      get 'revert_version', to: 'campaigns#revert_version', as: 'revert_version'
    end

    collection do
      get 'index_all', to: 'campaigns#index', as: 'index_all'
    end
  end

  root to: 'pages#home'
end 