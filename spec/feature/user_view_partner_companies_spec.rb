require 'rails_helper'

feature 'user view partner companies' do
  scenario 'successfully view index' do
    user = User.create!(email: 'user@espertofit.com.br', password: '123456789',
                        full_name: 'João da Silva', social_name: 'João da Silva')
    company = create(:partner_company, name: 'Empresa AAA', cnpj: '90.530.299/0001-89',
                                       address: 'Av. Jabaquara, 1000', email: 'usuario@empresaAAA.com.br')
    other_company = create(:partner_company, name: 'Empresa BBB', cnpj: '86.010.460/0001-16',
                                             address: 'Av. Jabaquara, 5', email: 'usuario@empresaBBB.com.br')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'

    expect(page).to have_link('Empresa AAA', href: partner_company_path(company))
    expect(page).to have_link('Empresa BBB', href: partner_company_path(other_company))
  end

  scenario 'there is no companies registered' do
    user = User.create!(email: 'user@espertofit.com.br', password: '123456789',
                        full_name: 'João da Silva', social_name: 'João da Silva')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'

    expect(page).to have_content('Nenhuma empresa parceira cadastrada')
  end

  scenario 'successfully view details' do
    user = User.create!(email: 'user@espertofit.com.br', password: '123456789',
                        full_name: 'João da Silva', social_name: 'João da Silva')
    create(:partner_company, name: 'Empresa AAA', cnpj: '90.530.299/0001-89',
                             address: 'Av. Jabaquara, 1000', email: 'usuario@empresaAAA.com.br')
    create(:partner_company, name: 'Empresa BBB', cnpj: '86.010.460/0001-16',
                             address: 'Av. Jabaquara, 5', email: 'usuario@empresaBBB.com.br')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa AAA'

    expect(page).to have_content('Empresa AAA')
    expect(page).to have_content('90.530.299/0001-89')
    expect(page).to have_content('Av. Jabaquara, 1000')
    expect(page).to have_content('usuario@empresaAAA.com.br')
    expect(page).not_to have_content('Empresa BBB')
    expect(page).not_to have_content('86.010.460/0001-16')
  end
end
