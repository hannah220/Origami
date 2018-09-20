class Customer < ApplicationRecord
  has_many :orders
  has_many :billing_addr
  has_many :shipping_addr
end
