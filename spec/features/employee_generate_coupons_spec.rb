require 'rails_helper'

feature 'user creates coupons' do
  scenario 'successfully' do
    create(:promotion, token: 'PROMONEW2')
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'

    expect(page).to have_content('PROMONEW2001', count: 1)
    expect(page).to have_content('PROMONEW2010', count: 1)
    expect(page).to have_content('PROMONEW2005', count: 1)
    expect(page).not_to have_content('PROMONEW2011')
    expect(page).not_to have_content('PROMONEW2000')
    expect(page).to have_content('Promoção de natal', count: 1)
  end

  scenario 'automatically reduce coupon quantity from promotion' do
    promotion = create(:promotion, token: 'PROMONEW2')
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    promotion.reload

    expect(promotion.coupon_quantity).to eq 0
  end
  scenario 'disable emission button for zero coupon quantity promotions' do
    create(:promotion, coupon_quantity: 0)
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'

    expect(page).not_to have_link('Emitir cupons')
  end
end
