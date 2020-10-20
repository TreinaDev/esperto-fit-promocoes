require 'rails_helper'

feature 'Promotion' do
  let(:admin) { create(:user, admin: true) }

  scenario 'is edited by admin' do
    create(:promotion, name: 'Promoção de natal', description: 'Promoção festiva de natal.',
                       discount_rate: 20, coupon_quantity: 30, monthly_duration: 3,
                       expire_date: Date.parse('09/09/2024'), token: 'PROMONAT')

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Nome', with: 'Promoção natalina'
    fill_in 'Descrição', with: 'Promoção especial de natal.'
    fill_in 'Percentual de desconto', with: 10
    fill_in 'Número de mensalidade(s)', with: 6
    fill_in 'Cupons disponíveis', with: 50
    fill_in 'Código da promoção', with: 'PNATAL'
    fill_in 'Período de validade', with: '13/04/2050'
    click_on 'Enviar'

    expect(page).to have_content 'Promoção editada com sucesso!'
    expect(page).to have_content 'Promoção natalina'
    expect(page).to have_content 'Promoção especial de natal.'
    expect(page).to have_content 'Percentual de desconto 10,0%'
    expect(page).to have_content 'Cupons disponíveis 50'
    expect(page).to have_content 'Número de mensalidade(s) 6'
    expect(page).to have_content 'PNATAL'
    expect(page).to have_content '13/04/2050'
  end

  scenario 'token is automatically upcased when edited' do
    create(:promotion, token: 'PROMONAT')

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Código da promoção', with: 'pronatal'
    click_on 'Enviar'

    expect(page).to have_content 'PRONATAL'
  end

  scenario 'attributes cannot be blank (except monthly_duration)' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Percentual de desconto', with: ''
    fill_in 'Cupons disponíveis', with: ''
    fill_in 'Código da promoção', with: ''
    fill_in 'Período de validade', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 6)
  end

  scenario 'token must be unique' do
    create(:promotion, token: 'PROMONAT')
    create(:promotion, name: 'Black Friday', token: 'PROMOBF')

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Black Friday'
    click_on 'Editar promoção'
    fill_in 'Código da promoção', with: 'PROMONAT'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso', count: 1)
  end

  scenario 'discount and coupon quantity cannot be negative' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Percentual de desconto', with: '-5'
    fill_in 'Cupons disponíveis', with: '-20'
    click_on 'Enviar'

    expect(page).to have_content('deve ser positivo', count: 2)
  end

  scenario 'discount cannot be greater than hundred' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Percentual de desconto', with: '105'
    click_on 'Enviar'

    expect(page).to have_content('deve ser menor ou igual a 100', count: 1)
  end

  scenario 'expire date cannot be past' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Período de validade', with: '10/01/2019'
    click_on 'Enviar'

    expect(page).to have_content('precisa ser uma data futura', count: 1)
  end

  scenario 'token cannot be less than 6 characters' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Código da promoção', with: 'PROMO'
    click_on 'Enviar'

    expect(page).to have_content('é muito curto (mínimo: 6 caracteres)', count: 1)
  end

  scenario 'token cannot be more than 10 characters' do
    create(:promotion)

    login_as admin

    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'
    click_on 'Editar promoção'
    fill_in 'Código da promoção', with: 'PROMONATALINA'
    click_on 'Enviar'

    expect(page).to have_content('é muito longo (máximo: 10 caracteres)', count: 1)
  end

  scenario 'with emitted coupons cannot show edit link' do
    create(:promotion, coupon_quantity: 0)

    login_as admin
    visit root_path
    click_on 'Promoções'
    click_on 'Promoção de natal'

    expect(page).not_to have_link('Editar promoção')
  end

  scenario 'with emitted coupons cannot be edited' do
    promotion = create(:promotion, coupon_quantity: 0)

    login_as admin

    visit edit_promotion_path(promotion)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para essa ação'
  end

  scenario 'cannot be edited by non-admin' do
    user = create(:user)
    promotion = create(:promotion)

    login_as user
    visit edit_promotion_path(promotion)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para essa ação'
  end
end
