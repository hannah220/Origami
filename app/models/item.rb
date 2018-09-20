class Item < ApplicationRecord
  validates_presence_of :name
  validates_numericality_of :price, :only_integer => true, :greater_than => 0
  belongs_to :category
  has_and_belongs_to_many :colors
  has_and_belongs_to_many :sizes, :join_table => :items_sizes
  has_and_belongs_to_many :options
  
  has_many :orders, through: :orders_lines
  has_many :orders_lines
end

class ItemsSizes < ApplicationRecord
  belongs_to :item
  belongs_to :size
end

class ItemsColors < ApplicationRecord
  belongs_to :item
  belongs_to :color
end
