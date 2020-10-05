class RemoveSubsidiaryFromCoupons < ActiveRecord::Migration[6.0]
  def change
    remove_column :coupons, :subsidiary_id
  end
end
