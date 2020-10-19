require 'rails_helper'

feature 'Register single coupon' do
  scenario 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Cupons avulsos'
    click_on 'Novo cupom avulso'

    fill_in 'Código do cupom', with: 'avulso123'
    fill_in 'Percentual de desconto', with: 20
    fill_in 'Data de validade', with: '09/09/2022'
    fill_in 'Número de mensalidade(s)', with: 6
    click_on 'Gerar cupom'

    expect(page).to have_content('AVULSO123')
    expect(page).to have_content('20,0%')
    expect(page).to have_content('09/09/2022')
    expect(page).to have_content('6')
    expect(page).to have_link('Voltar')
  end

  scenario 'and view only not expired coupons' do
    user = create(:user)
    create(:single_coupon, token: 'ANIVER251', expire_date: '09/09/2026')
    create(:single_coupon, token: 'EXPIRED', expire_date: '13/10/2021', discount_rate: 65)

    login_as user
    visit root_path
    travel_to Time.zone.local(2025, 10, 1, 12, 30, 45) do
      click_on 'Cupons avulsos'
    end

    expect(page).to have_content('ANIVER251')
    expect(page).not_to have_content('EXPIRED')
    expect(page).not_to have_content('65,0%')
  end

  scenario 'and view only not used coupons' do
    user = create(:user)
    create_list(:single_coupon, 3)
    create(:single_coupon, status: :consumed, token: 'DONTSHOW', discount_rate: 65)

    login_as user
    visit root_path
    click_on 'Cupons avulsos'

    expect(page).to have_content('ANIVER251')
    expect(page).to have_content('ANIVER252')
    expect(page).to have_content('ANIVER253')
    expect(page).not_to have_content('DONTSHOW')
    expect(page).not_to have_content('65,0%')
  end

  scenario 'view details' do
    user = create(:user)
    create(:single_coupon, token: 'ANIVER251')

    login_as user
    visit root_path
    click_on 'Cupons avulsos'
    click_on 'ANIVER251'

    expect(page).to have_content('ANIVER251')
    expect(page).to have_content('20,0%')
    expect(page).to have_content('09/09/2022')
    expect(page).to have_content('0')
  end

  scenario 'with blank fields' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Cupons avulsos'
    click_on 'Novo cupom avulso'

    fill_in 'Código do cupom', with: ''
    fill_in 'Percentual de desconto', with: ''
    fill_in 'Data de validade', with: ''
    fill_in 'Número de mensalidade(s)', with: ''
    click_on 'Gerar cupom'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end
