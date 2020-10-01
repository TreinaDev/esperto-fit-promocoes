FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "teste#{i}@espertofit.com.br" }
    password { '12345678' }
  end
end
