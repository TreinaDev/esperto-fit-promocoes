class CreatePartnerCompanyEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_company_employees do |t|
      t.string :cpf
      t.references :partner_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
