require 'rails_helper'

feature 'user creates coupons' do
  scenario 'successfully' do
    create(:promotion)
    user = create(:user)
    login_as user
    
    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Emitir cupons'
    fill_in 'Quantidade de cupons emitidos', with: 10
    select 'Paulista'

    expect(page).to have_content('PROMONEW1001', count: 1)
    expect(page).to have_content('PROMONEW1010', count: 1)
    expect(page).to have_content('PROMONEW1005', count: 1)
    expect(page).not_to have_content('PROMONEW1011')
    expect(page).not_to have_content('PROMONEW1000')
    expect(page).to have_content('Pode ser usado 50 vezes', count: 1)
    expect(page).to have_content('Promoção de natal', count: 1)
    expect(page).to have_content('Unidade Paulista', count: 1)

  end
end