FactoryBot.define do
  factory :partner_company do
    sequence(:name) { |i| "Empresa#{i}" }
    cnpj { CNPJ.generate(formatted: true) }
    address { 'Av. Paulista, 1000' }
    sequence(:email) { |i| "usuario@empresa#{i}.com.br" }
    discount_duration { 12 }
    discount_duration_undefined { false }
    discount { 30.0 }
    user
  end
end
