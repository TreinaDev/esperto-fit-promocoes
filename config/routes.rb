Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :promotions, only: [:index, :show, :create, :new]
  resources :partner_companies, only: [:index, :show, :new, :create]
end
