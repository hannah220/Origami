class RemoveShippingAddrIdFromCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :shipping_addr_id, :integer
  end
end
