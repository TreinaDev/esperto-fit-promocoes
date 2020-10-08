class AddCpfIndexToPartnerCompanyEmployee < ActiveRecord::Migration[6.0]
  def change
    add_index :partner_company_employees, :cpf, unique: true
  end
end
