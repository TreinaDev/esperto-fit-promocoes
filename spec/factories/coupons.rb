FactoryBot.define do
  factory :coupon do
    sequence(:token) { |j| "PROMONAT#{j.to_s.rjust(3, '0')}" }
    promotion
  end
end
