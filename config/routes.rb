Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :promotions, only: %i[index show create new]
  resources :promotions, only: %i[show] do
    post 'emission', on: :member
    resources :coupons
  end 
  resources :partner_companies, only: %i[index show new create]
end
