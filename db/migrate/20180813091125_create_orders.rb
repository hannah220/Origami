class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.datetime :order_date
      t.datetime :ship_date
      t.string :status

      t.timestamps
    end
  end
end
