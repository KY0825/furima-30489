class  UserOrder
  include ActiveModel::Model
  # 配送先についてのバリデーション
  attr_accesor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user, :item

  with_options presence: true do
    validates :postal_code,format: { with: /\A[0-9]+\z/}
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number,format: { with: /\A[0-9]+\z/}
    validates :user
  end
  # //配送先についてのバリデーション
  # 「配送先」の都道府県に関するバリデーション
  validates :prefecture_id,numericality: {other_than: 1}
  # //「配送先」の都道府県に関するバリデーション

  def save
    order = Order.create(user: user,item: item)
    customer_address = CustomerAddress.create(postal_code: postal_code,prefecture_id: prefecture_id,city: city, address: address,building_name: building_name,phone_number: phone_number)
  end
end