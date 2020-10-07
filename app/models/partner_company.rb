class PartnerCompany < ApplicationRecord
  belongs_to :user
  has_many :partner_company_employees, dependent: :destroy

  validates :name, :cnpj, :address, :email, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_validation

  def cnpj_validation
    return if CNPJ.valid?(cnpj)

    errors.add(:cnpj, :invalid)
  end

  def add_employee(cpf_list)
    invalid_cpfs = []
    cpf_list.each do |cpf|
      partner_company_employee = PartnerCompanyEmployee.new(cpf: cpf.strip, partner_company_id: id)

      next if partner_company_employee.save

      invalid_cpfs << cpf.strip
    end
    invalid_cpfs
  end

  def remove_employee(cpf_list)
    invalid_cpfs = []
    cpf_list.uniq!
    cpf_list.each do |cpf|
      if (cpf_to_remove = PartnerCompanyEmployee.find_by(cpf: cpf.strip))
        PartnerCompanyEmployee.destroy(cpf_to_remove.id)
      else
        invalid_cpfs << cpf.strip
      end
    end
    invalid_cpfs
  end
end
