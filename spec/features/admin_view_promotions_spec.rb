require 'rails_helper'

feature 'Admin view promotions' do
  scenario 'successfully' do
    admin = create(:user, admin: true)
    create(:promotion, name: 'Promoção natalina', discount_rate: 20, expire_date: Date.parse('09/09/2024'))

    login_as admin

    visit root_path
    click_on 'Promoções'

    expect(page).to have_content 'Promoção natalina'
    expect(page).to have_content 'Desconto: 20,0%'
    expect(page).to have_content 'Expira dia: 09/09/2024'
  end
end
