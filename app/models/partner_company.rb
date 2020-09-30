class PartnerCompany < ApplicationRecord
  validates :name, :cnpj, :address, :email, presence: { message: 'não pode ficar em branco' }
end
