class CreateOrderLines < ActiveRecord::Migration[5.1]
  def change
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :item_amount

      t.timestamps
    end
  end
end
