class PartnerCompany < ApplicationRecord
  belongs_to :user

  validates :name, :cnpj, :address, :email,
            presence: true
  validates :cnpj, uniqueness: true
end
