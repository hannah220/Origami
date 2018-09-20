class RemoveBillingAddrIdFromCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :billing_addr_id, :integer
  end
end
