class CreateItems < ActiveRecord::Migration[5.1]
  class Category < ActiveRecord::Base; end
  class Size < ActiveRecord::Base; end
  class Color < ActiveRecord::Base; end
  class Option < ActiveRecord::Base; end
  
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :category_id

      t.timestamps
    end

    # Create connection table between items and sizes
    create_table :items_sizes, :id => false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :size, index: true
    end

    # Create connection table between items and colors
    create_table :colors_items, :id => false do |t|
      t.belongs_to: :item, index: true
      t.belongs_to :color, index: true
    end

    # Create connection table between items and options
    create_table :items_options, :id => false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :option, index: true
    end
  end
end
