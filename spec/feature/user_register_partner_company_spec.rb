require 'rails_helper'

feature 'User register partner company' do
  scenario 'must be logged in to register a partner company' do
    create(:partner_company)

    visit new_partner_company_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully with indefinite duration' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Cadastrar Empresa'
    fill_in 'Nome', with: 'Empresa 1'
    fill_in 'CNPJ', with: '34.761.358/0001-59'
    fill_in 'Endereço', with: 'Av. Paulista, 1000'
    fill_in 'Email', with: 'usuario@empresa1.com.br'
    fill_in 'Desconto', with: '30'
    choose 'Prazo Indefinido'
    click_on 'Cadastrar'

    expect(page).to have_content('Empresa 1')
    expect(page).to have_content('34.761.358/0001-59')
    expect(page).to have_content('Av. Paulista, 1000')
    expect(page).to have_content('usuario@empresa1.com.br')
    expect(page).to have_content('Empresa cadastrada com sucesso')
    expect(page).to have_content('30%')
    expect(page).to have_content('Indefinido')
  end

  scenario 'successfully with defined duration' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Cadastrar Empresa'
    fill_in 'Nome', with: 'Empresa 1'
    fill_in 'CNPJ', with: '34.761.358/0001-59'
    fill_in 'Endereço', with: 'Av. Paulista, 1000'
    fill_in 'Email', with: 'usuario@empresa1.com.br'
    fill_in 'Desconto', with: '30'
    choose 'Prazo Definido'
    fill_in 'Duração', with: '12'
    click_on 'Cadastrar'

    expect(page).to have_content('Empresa 1')
    expect(page).to have_content('34.761.358/0001-59')
    expect(page).to have_content('Av. Paulista, 1000')
    expect(page).to have_content('usuario@empresa1.com.br')
    expect(page).to have_content('Empresa cadastrada com sucesso')
    expect(page).to have_content('30%')
    expect(page).to have_content('12 meses')
  end

  scenario 'duration must be nil when indefinite is true' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Cadastrar Empresa'
    fill_in 'Nome', with: 'Empresa 1'
    fill_in 'CNPJ', with: '34.761.358/0001-59'
    fill_in 'Endereço', with: 'Av. Paulista, 1000'
    fill_in 'Email', with: 'usuario@empresa1.com.br'
    fill_in 'Desconto', with: '30'
    choose 'Prazo Definido'
    fill_in 'Duração', with: '12'
    choose 'Prazo Indefinido'
    click_on 'Cadastrar'

    expect(page).to have_content('Empresa 1')
    expect(page).to have_content('34.761.358/0001-59')
    expect(page).to have_content('Av. Paulista, 1000')
    expect(page).to have_content('usuario@empresa1.com.br')
    expect(page).to have_content('Empresa cadastrada com sucesso')
    expect(page).to have_content('30%')
    expect(page).to have_content('Indefinido')
    expect(PartnerCompany.last.duration).to eq nil
  end

  scenario 'fields cannot be blank' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Cadastrar Empresa'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end
end
