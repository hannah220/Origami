class ChangeAssosiationTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :items_sizes
    drop_table :colors_items
    drop_table :items_options

    # Create connection table between items and sizes
    create_table :items_sizes, :id => false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :size, index: true
    end

    # Create connection table between items and colors
    create_table :items_colors, :id => false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :color, index: true
    end

    # Create connection table between items and options
    create_table :items_options, :id => false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :option, index: true
    end

  end
end
