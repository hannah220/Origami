class CreateBillingAddrs < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_addrs do |t|
      t.string :street
      t.string :postal
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
