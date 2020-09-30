class AddCnpjIndexToPartnerCompany < ActiveRecord::Migration[6.0]
  def change
    add_index :partner_companies, :cnpj, unique: true
  end
end
