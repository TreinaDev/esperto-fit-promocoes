FactoryBot.define do
  factory :user do
    sequence :email do |i|
      "teste#{i}@espertofit.com.br"
    end
    password { '12345678' }
  end
end
