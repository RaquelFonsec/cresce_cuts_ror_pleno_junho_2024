Rails.application.routes.draw do
  get 'discounts/create'
  get 'discounts/update'
  get 'discounts/destroy'
  get 'campaigns/index'
  get 'campaigns/show'
  get 'campaigns/new'
  get 'campaigns/create'
  get 'campaigns/edit'
  get 'campaigns/update'
  get 'campaigns/destroy'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
