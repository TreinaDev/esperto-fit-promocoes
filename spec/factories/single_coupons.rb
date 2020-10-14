FactoryBot.define do
  factory :single_coupon do
    sequence(:token) { |i| "ANIVER25#{i}" }
    discount_rate { '20' }
    expire_date { Date.parse('09/09/2022') }
    monthly_duration { 0 }
    consumed { false }
  end
end
