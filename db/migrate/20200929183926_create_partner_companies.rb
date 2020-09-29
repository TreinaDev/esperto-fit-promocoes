class CreatePartnerCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_companies do |t|
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
