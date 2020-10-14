class AddIndexToSingleCouponsToken < ActiveRecord::Migration[6.0]
  def change
    add_index :single_coupons, :token, unique: true
  end
end
