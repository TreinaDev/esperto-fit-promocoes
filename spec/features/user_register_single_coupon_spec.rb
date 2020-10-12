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

  scenario 'view details' do
    user = create(:user)
    create(:single_coupon)

    login_as user
    visit root_path
    click_on 'Cupons avulsos'
    click_on 'ANIVER251'

    expect(page).to have_content('ANIVER251')
    expect(page).to have_content('20,0%')
    expect(page).to have_content('09/09/2022')
    expect(page).to have_content('0')
  end
end
