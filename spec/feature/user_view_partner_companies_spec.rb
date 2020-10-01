require 'rails_helper'

feature 'user view partner companies' do
  scenario 'must be logged in' do
    visit partner_companies_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully view index' do
    user = create(:user)

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
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'

    expect(page).to have_content('Nenhuma empresa parceira cadastrada')
  end

  scenario 'must be logged in to view details' do
    company = create(:partner_company)

    visit partner_company_path(company)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully view details when indefinite is true' do
    user = create(:user)

    company = create(:partner_company, name: 'Empresa AAA', cnpj: '90.530.299/0001-89',
                                       address: 'Av. Jabaquara, 1000', email: 'usuario@empresaAAA.com.br',
                                       indefinite: true, duration: nil, discount: 30.0)
    create(:partner_company, name: 'Empresa BBB', cnpj: '86.010.460/0001-16')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa AAA'

    expect(page).to have_content('Empresa AAA')
    expect(page).to have_content('90.530.299/0001-89')
    expect(page).to have_content('Av. Jabaquara, 1000')
    expect(page).to have_content('usuario@empresaAAA.com.br')
    expect(page).to have_content('30%')
    expect(page).to have_content('Indefinido')
    expect(page).not_to have_content('Empresa BBB')
    expect(page).not_to have_content('86.010.460/0001-16')
    expect(page).to have_content(company.user.email)
  end

  scenario 'successfully view details when indefinite is false' do
    user = create(:user)

    company = create(:partner_company, name: 'Empresa AAA', cnpj: '90.530.299/0001-89',
                                       address: 'Av. Jabaquara, 1000', email: 'usuario@empresaAAA.com.br',
                                       indefinite: false, duration: 12, discount: 30.0)
    create(:partner_company, name: 'Empresa BBB', cnpj: '86.010.460/0001-16')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Empresas Parceiras'
    click_on 'Empresa AAA'

    expect(page).to have_content('Empresa AAA')
    expect(page).to have_content('90.530.299/0001-89')
    expect(page).to have_content('Av. Jabaquara, 1000')
    expect(page).to have_content('usuario@empresaAAA.com.br')
    expect(page).to have_content('30%')
    expect(page).to have_content('12 meses')
    expect(page).not_to have_content('Empresa BBB')
    expect(page).not_to have_content('86.010.460/0001-16')
    expect(page).to have_content(company.user.email)
  end
end
