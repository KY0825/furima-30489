class CustomerAddress < ApplicationRecord
  with_options presence: true do
    validates :postal_code,format: { with: /\A[0-9]+\z/}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number,format: { with: /\A[0-9]+\z/}
    validates :user
  end

  validates :prefecture_id,numericality: {other_than: 1}

end