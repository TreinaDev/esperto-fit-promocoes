FactoryBot.define do
  factory :partner_company do
    sequence (:name) { |i| "Empresa#{i}" }
    cnpj { "34.761.358/0001-59" }
    address { "Av. Paulista, 1000" }
    sequence (:email) { |i| "usuario@empresa#{i}.com.br" }
  end
end
