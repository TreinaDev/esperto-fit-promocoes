require 'rails_helper'

feature 'Regular user discards a coupon' do
  scenario 'from promotion successfully' do
    user = create(:user)
    login_as user
    create(:promotion, coupon_quantity: 1)

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    travel_to Time.zone.local(2024, 05, 05, 12, 30, 45) do
      click_on 'Descartar'
    end

    expect(page).to have_content 'DESCARTADO'
    expect(page).to have_content '05/05/2024'
    expect(coupon.discarded?).to be_true
  end
end