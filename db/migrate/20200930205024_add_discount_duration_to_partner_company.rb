class AddDiscountDurationToPartnerCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :partner_companies, :discount, :decimal
    add_column :partner_companies, :duration, :integer
    add_column :partner_companies, :indefinite, :boolean, default: false
  end
end
