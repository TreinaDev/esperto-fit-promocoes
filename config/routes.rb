Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :partner_companies, only: %i[index show new create] do
    resources :partner_company_employees, only: %i[index show new create] do
      get 'remove_form', on: :member
      post 'remove_cpfs', on: :member
    end
  end
  resources :promotions, only: %i[index show create new]
end
