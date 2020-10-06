FactoryBot.define do
  factory :coupon do
    token { 'MyString' }
    promotion { nil }
    coupon_number { 1 }
    use_counter { 1 }
  end
end
