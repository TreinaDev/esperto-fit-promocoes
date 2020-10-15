require 'rails_helper'

describe Client, type: :model do
  describe '#where' do
    it 'fetch all clients from company' do
      partner_company = create(:partner_company, name: 'Empresa Um', discount: 30.0, discount_duration: 12)
      json_content = File.read(Rails.root.join('spec/support/apis/get_clients.json'))
      faraday_response = double('clients', status: 200, body: json_content)

      allow(Faraday).to receive(:get).with('https://localhost:4000/api/v1/clients',
                                           { company_id: partner_company.id.to_s })
                                     .and_return(faraday_response)

      result = Client.where(partner_company.id.to_s)

      expect(result.length).to eq 2
      expect(result.first.email).to eq('client1@email.com')
      expect(result.first.name).to eq('Paula Ferreira')
      expect(result.first.cpf).to eq('463.383.030-95')
      expect(result.first.company_id).to eq(1)
      expect(result.last.email).to eq('client2@email.com')
      expect(result.last.name).to eq('Pedro Tavares')
      expect(result.last.cpf).to eq('277.868.468-91')
      expect(result.last.company_id).to eq(1)
    end

    it 'no clients found' do
      partner_company = create(:partner_company, name: 'Empresa Dois', discount: 30.0, discount_duration: 12, id: 2)
      faraday_response = double('clients', status: 404, body: {})

      allow(Faraday).to receive(:get).with('https://localhost:4000/api/v1/clients',
                                           { company_id: partner_company.id.to_s })
                                     .and_return(faraday_response)

      result = Client.where(partner_company.id.to_s)

      expect(result).to be_blank
    end
  end
end
