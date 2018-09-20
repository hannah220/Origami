class CreateItemSizes < ActiveRecord::Migration[5.1]
  def change
    create_table :item_sizes do |t|
      t.integer :item_id
      t.integer :size_id

      t.timestamps
    end
  end
end
