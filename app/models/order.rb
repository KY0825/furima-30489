class Order < ApplicationRecord
  has_one :customer_address
  belongs_to :item
end
