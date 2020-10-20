require 'rails_helper'

describe 'Consumed coupons cannot be discarded' do
  it 'promotion coupons' do
    user = create(:user)
    coupon = create(:coupon, status: :consumed)

    login_as user
    post "/promotions/#{coupon.promotion.id}/coupons/#{coupon.id}/discard", params: { status: :discarded }
    coupon.reload

    expect(coupon.status).to eq 'consumed'
  end

  it 'single coupons' do
    user = create(:user)
    single_coupon = create(:single_coupon, status: :consumed)

    login_as user
    post "/single_coupons/#{single_coupon.id}/discard", params: { status: :discarded }
    single_coupon.reload

    expect(single_coupon.status).to eq 'consumed'
  end
end
