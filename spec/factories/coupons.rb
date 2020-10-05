FactoryBot.define do
  factory :coupon do
    token { "MyString" }
    promotion { nil }
    coupon_number { 1 }
    subsidiary { nil }
    use_counter { 1 }
  end
end
