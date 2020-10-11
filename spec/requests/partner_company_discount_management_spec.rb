require 'rails_helper'

describe 'Partner Company discount management' do
  it 'found cpf and returns company discount with limited duration' do
    partner_company = create(:partner_company, discount: 30, discount_duration: 2, name: 'EmpresaA')
    partner_company_employee = create(:partner_company_employee, partner_company: partner_company,
                                                                 cpf: '663.513.501-40')
    get "/api/v1/partner_companies/search?q=#{partner_company_employee.cpf}"

    response_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(response_json[:discount]).to eq('30.0')
    expect(response_json[:format_discount_duration]).to eq('2')
    expect(response_json[:name]).to eq('EmpresaA')
    expect(response_json[:id]).to eq(partner_company.id)
  end
  it 'found cpf and returns company discount with unlimited duration' do
    partner_company = create(:partner_company, discount: 30, discount_duration_undefined: true, name: 'EmpresaA')
    partner_company_employee = create(:partner_company_employee, partner_company: partner_company,
                                                                 cpf: '663.513.501-40')
    get "/api/v1/partner_companies/search?q=#{partner_company_employee.cpf}"

    response_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(response_json[:discount]).to eq('30.0')
    expect(response_json[:format_discount_duration]).to eq('Indefinido')
    expect(response_json[:name]).to eq('EmpresaA')
    expect(response_json[:id]).to eq(partner_company.id)
  end
  it 'cannot find cpf' do
    create(:partner_company, discount: 30, discount_duration_undefined: true, name: 'EmpresaA')
    get '/api/v1/partner_companies/search?q=513.361.067-00'

    response_json = JSON.parse(response.body)

    expect(response).to have_http_status(404)
    expect(response.content_type).to include('application/json')
    expect(response_json).to include('Nenhum desconto para esse CPF')
  end
  it 'invalid params' do
    get '/api/v1/partner_companies/search'

    response_json = JSON.parse(response.body)

    expect(response).to have_http_status(412)
    expect(response.content_type).to include('application/json')
    expect(response_json).to include('CPF inválido')
  end
  it 'is not a valid cpf' do
    get '/api/v1/partner_companies/search?q=513361067001'

    response_json = JSON.parse(response.body)

    expect(response).to have_http_status(412)
    expect(response.content_type).to include('application/json')
    expect(response_json).to include('CPF inválido')
  end
end
