class AddDiscountDurationToPartnerCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :partner_companies, :discount, :decimal
    add_column :partner_companies, :discount_duration, :integer
    add_column :partner_companies, :discount_duration_undefined, :boolean, default: false
  end
end
