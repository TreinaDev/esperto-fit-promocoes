class AddStatusToSingleCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :single_coupons, :status, :integer, default: 0
    remove_column :single_coupons, :consumed
  end
end
