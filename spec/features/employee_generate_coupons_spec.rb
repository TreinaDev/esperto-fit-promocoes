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

  scenario 'enable coupons list button after emission' do
    promotion = create(:promotion, coupon_quantity: 0)
    coupon = create(:coupon, promotion: promotion)
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'

    expect(page).not_to have_link('Emitir cupons')
    expect(page).to have_content(coupon.token)
  end

  scenario 'view emitted coupons' do
    create(:promotion, token: 'PROMONAT')
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'

    expect(page).to have_content('PROMONAT001')
    expect(page).to have_content('PROMONAT005')
    expect(page).to have_content('PROMONAT001')
    expect(page).to have_content('PROMONAT010')
    expect(page).not_to have_content('PROMONAT000')
    expect(page).not_to have_content('PROMONAT011')
    expect(page).to have_content('Promoção de natal')
  end
  scenario 'a single coupon has same token of a promotion coupon' do
    create(:promotion, token: 'TESTES')
    create(:single_coupon, token: 'TESTES003')
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'

    expect(page).to have_content('TESTES001')
    expect(page).to have_content('TESTES002')
    expect(page).to have_content('TESTES011')
    expect(page).not_to have_content('TESTES003')
  end
end
