FactoryBot.define do
  factory :promotion do
    name { 'Promoção de natal' }
    description { 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.' }
    discount_rate { '100' }
    coupon_quantity { 50 }
    expire_date { Date.parse('09/09/2024') }
    sequence(:token) { |i| "PROMONEW#{i}" }
  end
end
