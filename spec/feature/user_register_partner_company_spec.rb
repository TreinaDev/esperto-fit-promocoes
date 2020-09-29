require 'rails_helper'

feature 'User register partner company' do
  scenario 'successfully' do
    user = User.create!(full_name: 'Carlos', social_name: 'Carlos',
                        email: 'carlos@espertofit.com.br', password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar empresa'
    fill_in 'Nome', with: 'Empresa 1'
    fill_in 'CNPJ', with: '34.761.358/0001-59'
    fill_in 'Endereço', with: 'Av. Paulista, 1000'
    fill_in 'Email', with: 'usuario@empresa1.com.br'
    click_on 'Cadastrar'

    expect(page).to have_content('Empresa 1')
    expect(page).to have_content('34.761.358/0001-59')
    expect(page).to have_content('Av. Paulista, 1000')
    expect(page).to have_content('usuario@empresa1.com.br')
    expect(page).to have_content('Empresa cadastrada com sucesso')
  end

  scenario 'fields cannot be blank' do
    user = User.create!(full_name: 'Carlos', social_name: 'Carlos',
                        email: 'carlos@espertofit.com.br', password: '123456789')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar empresa'
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')

  end
end