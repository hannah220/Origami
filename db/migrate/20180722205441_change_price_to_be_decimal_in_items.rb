class ChangePriceToBeDecimalInItems < ActiveRecord::Migration[5.1]
  def up
    change_column :items, :price, "decimal(8,2)"
  end
  def down
    change_column :items, :price, :integer
  end
end
