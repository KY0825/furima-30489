class Order < ApplicationRecord
  has_one :customer_address
end