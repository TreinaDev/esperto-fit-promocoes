require 'rails_helper'

feature 'User' do
  scenario 'create account' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Criar conta'
  end

  scenario 'create account and is not admin by default' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    click_on 'Enviar'

    expect(User.first.admin).to eq false
  end

  scenario 'login' do
    create(:user, email: 'teste@espertofit.com.br', password: '12345678')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Criar conta'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'login and logout' do
    create(:user, email: 'teste@espertofit.com.br', password: '12345678')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Criar conta'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
  end
end
