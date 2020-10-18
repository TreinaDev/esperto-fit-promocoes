require 'rails_helper'

feature 'Regular user discards a promotion coupon' do
  scenario 'successfully' do
    user = create(:user)
    login_as user
    promotion = create(:promotion, coupon_quantity: 1)

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    travel_to Time.zone.local(2024, 05, 05, 12, 30, 45) do
      click_on 'Descartar'
    end

    expect(page).to have_content 'PROMONAT1001'
    expect(page).to have_content '05/05/2024'
    expect(page).to have_content 'Carlos Ferreira'
    expect(Coupon.last.discarded?).to be true
  end

  scenario 'and undo the discard' do
    user = create(:user)
    login_as user
    promotion = create(:promotion, coupon_quantity: 1, token: 'PROMONAT1')

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    travel_to Time.zone.local(2024, 05, 05, 12, 30, 45) do
      click_on 'Descartar'
      click_on 'Desfazer descarte'
    end

    expect(page).to have_content 'PROMONAT1001'
    expect(page).not_to have_content '05/05/2024'
    expect(page).not_to have_content 'Carlos Ferreira'
    expect(Coupon.last.discarded?).to be false
  end

  scenario 'and discard again after undo' do
    user = create(:user)
    login_as user
    promotion = create(:promotion, coupon_quantity: 1, token: 'PROMONAT1')

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    click_on 'Descartar'
    click_on 'Desfazer descarte'
    travel_to Time.zone.local(2024, 05, 05, 12, 30, 45) do
       click_on 'Descartar'
    end

    expect(page).to have_content 'PROMONAT1001'
    expect(page).to have_content '05/05/2024'
    expect(page).to have_content 'Carlos Ferreira'
    expect(Coupon.last.discarded?).to be true
  end
end
