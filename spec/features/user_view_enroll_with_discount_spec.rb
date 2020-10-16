require 'rails_helper'

feature 'User view enrolls with discount' do
  let(:user) { create(:user) }
  scenario 'must be logged in' do
    partner_company = create(:partner_company)

    visit clients_partner_company_path(id: partner_company.id)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    partner_company = create(:partner_company)
    json_content = File.read(Rails.root.join('spec/support/apis/get_clients.json'))
    faraday_response = double('clients', status: 200, body: json_content)

    allow(Faraday).to receive(:get).with('https://localhost:4000/api/v1/clients',
                                         { company_id: partner_company.id.to_s })
                                   .and_return(faraday_response)
    login_as(user, scope: :user)

    visit root_path
    click_on('Empresas Parceiras')
    click_on(partner_company.name)
    click_on('Clientes com Desconto')

    expect(page).to have_content('Paula Ferreira - 463.383.030-95 - client1@email.com')
    expect(page).to have_content('Pedro Tavares - 277.868.468-91 - client2@email.com')
  end

  scenario 'no clients' do
    partner_company = create(:partner_company)
    faraday_response = double('clients', status: 404, body: {})

    allow(Faraday).to receive(:get).with('https://localhost:4000/api/v1/clients',
                                         { company_id: partner_company.id.to_s })
                                   .and_return(faraday_response)
    login_as(user, scope: :user)

    visit root_path
    click_on('Empresas Parceiras')
    click_on(partner_company.name)
    click_on('Clientes com Desconto')

    expect(page).to have_content('Nenhum cliente com desconto')
  end
end
