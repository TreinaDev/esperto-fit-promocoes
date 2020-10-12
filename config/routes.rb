Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :partner_companies, only: %i[index show new create] do
    resources :partner_company_employees, only: %i[index show new create] do
      get 'remove_form', on: :collection
      post 'remove_cpfs', on: :collection
    end
  end

  resources :promotions, only: %i[index create new]
  resources :promotions, only: %i[show] do
    post 'emission', on: :member
    resources :coupons
  end 

  namespace :api do
    namespace :v1 do
      resources :partner_companies do
        get 'search', on: :collection
      end
    end
  end
end
