require 'rails_helper'

feature 'Promotion' do
  let(:admin) { create(:user, admin: true) }

  scenario 'is registered by admin' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Nome', with: 'Promoção de natal'
    fill_in 'Descrição', with: 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    fill_in 'Percentual de desconto', with: 100
    fill_in 'Número máximo de uso', with: 50
    fill_in 'Código da promoção', with: 'PROMONAT'
    fill_in 'Período de validade', with: '13/01/2021'
    click_on 'Enviar'

    expect(page).to have_content 'Promoção cadastrada com sucesso!'
    expect(page).to have_content 'Promoção de natal'
    expect(page).to have_content 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    expect(page).to have_content '100,0% de desconto'
    expect(page).to have_content '50'
    expect(page).to have_content 'PROMONAT'
    expect(page).to have_content '13/01/2021'
  end

  scenario 'has a token when created' do
    login_as admin
    promo = create(:promotion)

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'

    expect(current_path).to eq promotion_path(promo)
    expect(page).to have_content 'Promoção de natal'
    expect(page).to have_content 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    expect(page).to have_content '100,0% de desconto'
    expect(page).to have_content '50'
    expect(page).to have_content '09/09/2024'
    expect(promo.token).to be_present
    expect(page).to have_content promo.token
  end

  scenario 'token is automatically upcased when saved' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Nome', with: 'Promoção de natal'
    fill_in 'Descrição', with: 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    fill_in 'Percentual de desconto', with: 100
    fill_in 'Número máximo de uso', with: 50
    fill_in 'Código da promoção', with: 'promonat10'
    fill_in 'Período de validade', with: '13/01/2021'
    click_on 'Enviar'

    expect(page).to have_content 'Promoção cadastrada com sucesso!'
    expect(page).to have_content 'Promoção de natal'
    expect(page).to have_content 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    expect(page).to have_content '100,0% de desconto'
    expect(page).to have_content '50'
    expect(page).to have_content 'PROMONAT10'
    expect(page).to have_content '13/01/2021'
  end

  scenario 'cannot be created by non-admin' do
    user = create(:user)

    login_as user
    visit new_promotion_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para essa ação'
  end
end
