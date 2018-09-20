class CreateItemColors < ActiveRecord::Migration[5.1]
  def change
    create_table :item_colors do |t|
      t.integer :item_id
      t.integer :color_id

      t.timestamps
    end
  end
end
