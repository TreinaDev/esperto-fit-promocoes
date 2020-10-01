FactoryBot.define do
  factory :user do
    full_name { 'Carlos Ferreira' }
    social_name { 'Carlos Ferreira' }
    sequence(:email) { |i| "teste#{i}@espertofit.com.br" }
    password { '12345678' }
  end
end
