class AddDiscardAttributesToSingleCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :single_coupons, :discard_date, :date
    add_column :single_coupons, :discard_user, :string
  end
end
