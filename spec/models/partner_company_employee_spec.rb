require 'rails_helper'

describe PartnerCompanyEmployee do
  context 'validation' do
    it 'cpf must be valid' do
      partner_company_employee = build(:partner_company_employee, cpf: '888')

      partner_company_employee.valid?

      expect(partner_company_employee.errors[:cpf]).to include('não é válido')
    end
  end
end
