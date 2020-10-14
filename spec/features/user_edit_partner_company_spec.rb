require 'rails_helper'

feature 'edit partner company' do
  scenario 'must be logged in to edit partner company' do
    company = create(:partner_company)

    visit edit_partner_company_path(company)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = create(:user)
    create(:partner_company, name: 'teste1', cnpj: '72.951.663/0001-00', address: 'Av. Paulista, 1000',
                             email: 'teste1@teste1.com.br', discount_duration: 12,
                             discount: 30, discount_duration_undefined: false)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'teste1'
    click_on 'Editar empresa parceira'
    fill_in 'Endereço', with: 'Av. Jabaquara, 1000'
    fill_in 'Desconto', with: '10'
    choose 'Prazo Definido'
    fill_in 'Prazo', with: '6'
    click_on 'Cadastrar'

    expect(page).to have_content('teste1')
    expect(page).to have_content('72.951.663/0001-00')
    expect(page).to have_content('teste1@teste1.com.br')
    expect(page).to have_content('Av. Jabaquara, 1000')
    expect(page).to have_content('10%')
    expect(page).to have_content('6 meses')
    expect(page).to have_content(user.email)
    expect(page).not_to have_content('Av. Paulista, 1000')
  end

  scenario 'successfully change to indefinite duration' do
    user = create(:user, email: 'teste20@espertofit.com.br')
    create(:partner_company, name: 'teste1', cnpj: '72.951.663/0001-00', address: 'Av. Paulista, 1000',
                             email: 'teste1@teste1.com.br', discount_duration: 12,
                             discount: 30, discount_duration_undefined: false)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'teste1'
    click_on 'Editar empresa parceira'
    fill_in 'Endereço', with: 'Av. Jabaquara, 1000'
    fill_in 'Desconto', with: '10'
    choose 'Prazo Indefinido'
    click_on 'Cadastrar'

    expect(page).to have_content('teste1')
    expect(page).to have_content('72.951.663/0001-00')
    expect(page).to have_content('teste1@teste1.com.br')
    expect(page).to have_content('Av. Jabaquara, 1000')
    expect(page).to have_content('10%')
    expect(page).to have_content('teste20@espertofit.com.br')
    expect(page).to have_content('Indefinido')
    expect(page).not_to have_content('Av. Paulista, 1000')
  end

  scenario 'fields cannot be blank' do
    user = create(:user)
    create(:partner_company, name: 'teste1', cnpj: '72.951.663/0001-00', address: 'Av. Paulista, 1000',
                             email: 'teste1@teste1.com.br', discount_duration: 12,
                             discount: 30, discount_duration_undefined: false)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'teste1'
    click_on 'Editar empresa parceira'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Email', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Prazo', with: '6'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
  end
end
