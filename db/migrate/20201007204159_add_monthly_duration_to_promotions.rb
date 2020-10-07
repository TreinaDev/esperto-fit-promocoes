class AddMonthlyDurationToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :monthly_duration, :integer
  end
end
