class CreateShippingAddrs < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_addrs do |t|
      t.string :street
      t.string :postal
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
