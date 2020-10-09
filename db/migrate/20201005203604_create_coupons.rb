class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :token
      t.references :promotion, null: false, foreign_key: true
      t.integer :coupon_number
      t.references :subsidiary, null: false, foreign_key: true
      t.integer :use_counter

      t.timestamps
    end
  end
end
