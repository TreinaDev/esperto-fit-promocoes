require 'rails_helper'

describe PartnerCompany do
  context 'validation' do
    it 'CNPJ must be unique' do
      create(:partner_company, cnpj: '49.249.588/0001-00')
      company = build(:partner_company, cnpj: '49.249.588/0001-00')

      company.valid?

      expect(company.errors[:cnpj]).to include('já está em uso')
    end

    it 'attributes cannot be blank' do
      company = PartnerCompany.new

      company.valid?

      expect(company.errors[:name]).to include('não pode ficar em branco')
      expect(company.errors[:cnpj]).to include('não pode ficar em branco')
      expect(company.errors[:address]).to include('não pode ficar em branco')
      expect(company.errors[:email]).to include('não pode ficar em branco')
      expect(company.errors[:user]).to include('é obrigatório(a)')
    end

    it 'cnpj must be valid' do
      company = build(:partner_company, cnpj: '49.44')

      company.valid?

      expect(company.errors[:cnpj]).to include('não é válido')
    end
  end
end
