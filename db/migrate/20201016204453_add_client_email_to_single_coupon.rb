class AddClientEmailToSingleCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :single_coupons, :client_email, :string
  end
end
