class AddConsumedToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :consumed, :boolean, default: false
  end
end
