class Order < ApplicationRecord
  has_many :order_line
  belongs_to :customer
end
