class AddUserToPartnerCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :partner_companies, :user, null: false, foreign_key: true
  end
end
