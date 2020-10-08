FactoryBot.define do
  factory :partner_company_employee do
    cpf { CPF.generate(formatted: true) }
    partner_company
  end
end
