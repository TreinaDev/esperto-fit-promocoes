Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :partner_companies, only: %i[index show new create] do
    resources :partner_company_employees, only: %i[index show new create]
      #get 'remove_form', on: :member
    get 'partner_company_employee/remove_form', to: 'partner_company_employees#remove_form'
    post 'partner_company_employee/remove_cpfs', to: 'partner_company_employees#remove_cpfs'
  end
  resources :promotions, only: %i[index show create new]
end
