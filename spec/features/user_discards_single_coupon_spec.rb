require 'rails_helper'

feature 'User discards a single coupon' do
  scenario 'successfully' do
    user = create(:user)
    login_as user
    single_coupon = create(:single_coupon, token: 'AVULSO123')

    visit root_path
    click_on 'Cupons avulsos'
    click_on 'AVULSO123'
    travel_to Time.zone.local(2022, 05, 05, 12, 30, 45) do
        click_on 'Descartar'
    end

    expect(page).to have_content 'AVULSO123'
    expect(page).to have_content '05/05/2022'
    expect(page).to have_content 'Carlos Ferreira'
    expect(SingleCoupon.last.discarded?).to be true
    end

  scenario 'and undo the discard' do
    user = create(:user)
    login_as user
    single_coupon = create(:single_coupon, token: 'AVULSO123')

    visit root_path
    click_on 'Cupons avulsos'
    click_on 'AVULSO123'
    travel_to Time.zone.local(2022, 05, 05, 12, 30, 45) do
      click_on 'Descartar'
      click_on 'Desfazer descarte'
    end

    expect(page).to have_content 'AVULSO123'
    expect(page).not_to have_content '05/05/2022'
    expect(page).not_to have_content 'Carlos Ferreira'
    expect(SingleCoupon.last.discarded?).to be false
  end

  scenario 'and discard again after undo' do
    user = create(:user)
    login_as user
    single_coupon = create(:single_coupon, token: 'AVULSO123')

    visit root_path
    click_on 'Cupons avulsos'
    click_on 'AVULSO123'
    click_on 'Descartar'
    click_on 'Desfazer descarte'
    travel_to Time.zone.local(2022, 05, 05, 12, 30, 45) do
       click_on 'Descartar'
    end

    expect(page).to have_content 'AVULSO123'
    expect(page).to have_content '05/05/2022'
    expect(page).to have_content 'Carlos Ferreira'
    expect(SingleCoupon.last.discarded?).to be true
  end
end
