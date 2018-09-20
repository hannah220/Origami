class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :shipping_addr_id
      t.integer :billing_addr_id

      t.timestamps
    end
  end
end
