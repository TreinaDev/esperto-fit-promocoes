require 'rails_helper'

feature 'User deletes partner compnay employees' do
  scenario 'must be logged in to delete cpfs' do
    company = create(:partner_company)

    visit partner_company_partner_company_employee_remove_form_path(company)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = create(:user)
    company = create(:partner_company)
    create(:partner_company_employee, cpf: '193.145.460-47', partner_company: company)
    create(:partner_company_employee, cpf: '000.064.100-65', partner_company: company)
    create(:partner_company_employee, cpf: '425.609.410-58', partner_company: company)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on company.name
    click_on 'Remover CPF'
    attach_file 'Selecione o arquivo', Rails.root.join('spec/support/empresa_apaga_cpfs.txt')
    click_on 'Remover'

    expect(page).to have_content('2 CPF(s) removido(s) com sucesso')
    expect(page).to have_content('193.145.460-47')
  end

  scenario 'must attach a file' do
    user = create(:user)
    create(:partner_company, name: 'Empresa teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Remover CPF'
    click_on 'Remover'

    expect(page).to have_content('Selecione um arquivo de texto')
  end

  scenario 'file cannot be blank' do
    user = create(:user)
    create(:partner_company, name: 'Empresa teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Remover CPF'
    attach_file 'Selecione o arquivo', Rails.root.join('spec/support/teste_vazio.txt')
    click_on 'Remover'

    expect(page).to have_content('Arquivo vazio. Selecione arquivo com conteúdo')
  end

  scenario 'CPF must be registered to be deleted' do
    user = create(:user)
    create(:partner_company, name: 'Empresa teste')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Remover CPF'
    attach_file 'Selecione o arquivo', Rails.root.join('spec/support/empresa_apaga_cpfs.txt')
    click_on 'Remover'

    expect(page).to have_content('CPF(s) inválido(s): 000.064.100-65 425.609.410-58')
  end

  scenario 'duplicate CPF is deleted successfully' do
    user = create(:user)
    company = create(:partner_company, name: 'Empresa teste')
    create(:partner_company_employee, cpf: '574.097.590-54', partner_company: company)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa teste'
    click_on 'Remover CPF'
    attach_file 'Selecione o arquivo', Rails.root.join('spec/support/remove_cpf_duplicado.txt')
    click_on 'Remover'

    expect(page).to have_content('1 CPF(s) removido(s) com sucesso')
    expect(page).not_to have_content('CPF(s) inválido(s): 574.097.590-54')
  end
end
