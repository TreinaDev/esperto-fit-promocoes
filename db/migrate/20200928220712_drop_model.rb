class DropModel < ActiveRecord::Migration[6.0]
  def change
    drop_table :models
  end
end
