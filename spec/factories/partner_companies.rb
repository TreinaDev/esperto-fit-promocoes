FactoryBot.define do
  factory :partner_company do
    sequence(:name) { |i| "Empresa#{i}" }
    cnpj { CNPJ.generate(formatted: true) }
    address { 'Av. Paulista, 1000' }
    sequence(:email) { |i| "usuario@empresa#{i}.com.br" }
    user
  end
end
