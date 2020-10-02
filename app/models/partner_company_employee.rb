class PartnerCompanyEmployee < ApplicationRecord
  belongs_to :partner_company

  validate :cpf_validation
  validates :cpf, uniqueness: true

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :invalid)
  end
end
