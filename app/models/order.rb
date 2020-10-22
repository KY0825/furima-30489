class Order < ApplicationRecord
  validates :price,    presence: true
  has_one :customer_address
end
