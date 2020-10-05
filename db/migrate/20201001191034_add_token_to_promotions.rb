class AddTokenToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :token, :string
    add_index :promotions, :token, unique: true
  end
end
