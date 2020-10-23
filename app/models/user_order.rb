class UserOrder

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user, :item, :token

  # Orderに関するバリデーション
  validates :price, presence: true
  validates :token, presence: true
  # //Orderに関するバリデーション
  # CustomerAddressに関するバリデーション
  with_options presence: true do
    validates :postal_code,format: { with: /\A[0-9]+\z/}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number,format: { with: /\A[0-9]+\z/}
    validates :user
  end
  # //CustomerAddressに関するバリデーション
  # CustomerAddressの都道府県に関するバリデーション
  validates :prefecture_id,numericality: {other_than: 1}
  # //CustomerAddressの都道府県に関するバリデーション

  def save
    order = Order.create(user: user, item: item)
    customer_address = CustomerAddress.create(postal_code: postal_code ,prefecture_id: prefecture_id,city: city, address: address, building_name: building_name, phone_number: phone_number)
  end
end