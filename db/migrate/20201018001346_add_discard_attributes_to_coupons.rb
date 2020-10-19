class AddDiscardAttributesToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :discard_date, :date
    add_column :coupons, :discard_user, :string
  end
end
