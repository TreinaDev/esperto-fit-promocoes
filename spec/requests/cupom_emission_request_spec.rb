require 'rails_helper'

describe 'Promotion registration' do
  it 'must be admin in to create' do
    user = create(:user)
    promotion = create(:promotion, coupon_quantity: 0)
    login_as user
    post emission_promotion_path(promotion), params: {}

    expect(response.body).to include('Emissão de cupons indisponível')
    expect(response).to have_http_status(412)
  end
end
