require 'rails_helper'

feature 'User register cpf of partner company employee' do
  scenario 'successfully' do
    user = create(:user)
    company = create(:partner_company, name: 'Empresa teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Cadastrar CPF'
    attach_file 'Selecione o arquivo', Rails.root.join('spec/support/empresa_teste_cpfs.txt')
    click_on 'Cadastrar'

    expect(page).to have_content('4 CPFs cadastrados com sucesso')
    expect(page).to have_content('Funcionários de Empresa teste')
    expect(page).to have_content('013.942.940-93')
    expect(page).to have_content('963.036.880-39')
    expect(page).to have_content('922.467.600-62')
    expect(page).to have_content('574.097.590-54')
  end
  scenario 'must attach a file' do
    user = create(:user)
    company = create(:partner_company, name: 'Empresa teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Cadastrar CPF'
    click_on 'Cadastrar'

    expect(page).to have_content('Selecione um arquivo de texto')
  end
end