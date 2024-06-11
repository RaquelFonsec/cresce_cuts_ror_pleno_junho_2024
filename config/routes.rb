Rails.application.routes.draw do
  
  namespace :api do
    resources :products, only: [:index]
  end

  
  resources :campaigns do
    resources :discounts, only: [:new, :create, :update, :destroy]  
    get 'discount_history', to: 'campaigns#discount_history', on: :member
    member do
      get :revert_version
    end
  end


  devise_for :users
  root to: 'pages#home'
end
