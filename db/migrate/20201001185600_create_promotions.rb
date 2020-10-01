class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :description
      t.decimal :discount_rate
      t.integer :coupon_quantity
      t.date :expire_date

      t.timestamps
    end
  end
end
