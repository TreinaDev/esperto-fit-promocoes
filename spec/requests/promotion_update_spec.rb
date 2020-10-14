require 'rails_helper'

describe 'Promotion update' do
  it 'must not have coupons emitted' do
    admin = create(:user, admin: true)
    promotion = create(:promotion, coupon_quantity: 0)

    login_as admin
    patch promotion_path(promotion)

    expect(response).to redirect_to(root_path)
  end
end
