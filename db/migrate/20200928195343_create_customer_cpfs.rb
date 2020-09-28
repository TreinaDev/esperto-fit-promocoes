class CreateCustomerCpfs < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_cpfs do |t|
      t.references :company, null: false, foreign_key: true
      t.string :number

      t.timestamps
    end
  end
end
