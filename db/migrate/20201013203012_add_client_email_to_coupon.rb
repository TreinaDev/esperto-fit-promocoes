class AddClientEmailToCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :client_email, :string
  end
end
