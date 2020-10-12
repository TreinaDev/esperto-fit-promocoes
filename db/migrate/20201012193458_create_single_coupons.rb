class CreateSingleCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :single_coupons do |t|
      t.string :token, unique: true
      t.decimal :discount_rate
      t.date :expire_date
      t.integer :monthly_duration
      t.boolean :consumed, default: false

      t.timestamps
    end
  end
end
