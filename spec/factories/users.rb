FactoryBot.define do
  factory :user do
    full_name { 'Carlos Ferreira' }
    social_name { 'Carlos Ferreira' }
    sequence(:email) { |i| "usuario#{i}@espertofit.com.br" }
    password { '123456789' }
  end
end
