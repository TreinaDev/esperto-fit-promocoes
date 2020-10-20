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
    fill_in 'Número de mensalidade(s)', with: 6
    fill_in 'Cupons disponíveis', with: 50
    fill_in 'Código da promoção', with: 'PROMONAT'
    fill_in 'Período de validade', with: '13/01/2021'
    click_on 'Enviar'

    expect(page).to have_content 'Promoção cadastrada com sucesso!'
    expect(page).to have_content 'Promoção de natal'
    expect(page).to have_content 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    expect(page).to have_content 'Percentual de desconto 100,0%'
    expect(page).to have_content 'Cupons disponíveis 50'
    expect(page).to have_content 'Número de mensalidade(s) 6'
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
    expect(page).to have_content 'Percentual de desconto 100,0%'
    expect(page).to have_content 'Número de mensalidade(s) 6'
    expect(page).to have_content 'Cupons disponíveis 10'
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
    fill_in 'Número de mensalidade(s)', with: 6
    fill_in 'Cupons disponíveis', with: 50
    fill_in 'Código da promoção', with: 'promonat10'
    fill_in 'Período de validade', with: '13/01/2021'
    click_on 'Enviar'

    expect(page).to have_content 'Promoção cadastrada com sucesso!'
    expect(page).to have_content 'Promoção de natal'
    expect(page).to have_content 'Faça matrícula no período de natal e ganhe atendimento com nutricionista por um mês.'
    expect(page).to have_content 'Percentual de desconto 100,0%'
    expect(page).to have_content 'Cupons disponíveis 50'
    expect(page).to have_content 'Número de mensalidade(s) 6'
    expect(page).to have_content 'PROMONAT10'
    expect(page).to have_content '13/01/2021'
  end

  scenario 'attributes cannot be blank (except monthly_duration)' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end

  scenario 'token must be unique' do
    create(:promotion, token: 'PROMONAT')

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Código da promoção', with: 'PROMONAT'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso', count: 1)
  end

  scenario 'discount and coupon quantity cannot be negative' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Percentual de desconto', with: '-5'
    fill_in 'Cupons disponíveis', with: '-20'
    click_on 'Enviar'

    expect(page).to have_content('deve ser positivo', count: 2)
  end

  scenario 'discount cannot be greater than hundred' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Percentual de desconto', with: '105'
    click_on 'Enviar'

    expect(page).to have_content('deve ser menor ou igual a 100', count: 1)
  end

  scenario 'expire date cannot be past' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Período de validade', with: '10/01/2019'
    click_on 'Enviar'

    expect(page).to have_content('precisa ser uma data futura', count: 1)
  end

  scenario 'token cannot be less than 6 characters' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Código da promoção', with: 'PROMO'
    click_on 'Enviar'

    expect(page).to have_content('é muito curto (mínimo: 6 caracteres)', count: 1)
  end

  scenario 'token cannot be more than 10 characters' do
    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Cadastrar promoção'
    fill_in 'Código da promoção', with: 'PROMONATALINA'
    click_on 'Enviar'

    expect(page).to have_content('é muito longo (máximo: 10 caracteres)', count: 1)
  end

  scenario 'cannot be created by non-admin' do
    user = create(:user)

    login_as user
    visit new_promotion_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para essa ação'
  end
end
