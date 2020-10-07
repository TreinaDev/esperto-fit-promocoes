class RemoveUseCounterFromCoupons < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupons, :use_counter
  end
end
