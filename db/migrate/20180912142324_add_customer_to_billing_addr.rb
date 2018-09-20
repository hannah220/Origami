class AddCustomerToBillingAddr < ActiveRecord::Migration[5.1]
  def change
    add_column :billing_addrs, :customer_id, :integer
  end
end
