Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :partner_companies, only: %i[index show new create] do
    resources :partner_company_employees, only: %i[index show new create] do
      get 'remove_form', on: :collection
      post 'remove_cpfs', on: :collection
    end
  end

  resources :promotions, only: %i[index create new edit update]
  resources :promotions, only: %i[show] do
    post 'emission', on: :member
    resources :coupons
  end 
  resources :partner_companies, only: %i[index show new create]

  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      get 'coupons/:token', to: 'coupons#show'
      resources :partner_companies do
        get 'search', on: :collection
      end
      post 'coupon_burn', to: 'coupons#burn'
    end
  end
end
