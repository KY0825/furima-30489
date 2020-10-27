class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :image
    validates :name
    validates :text
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :delivery_area_id
    validates :days_id
    validates :price, numericality:{ only_interger: true,greater_than_or_equal_to: 299,less_than_or_equal_to: 10_000_000 },format: { with: /\A[0-9]+\z/}
    validates :user
  end

  has_one_attached :image
  has_one :order

  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_area
  belongs_to_active_hash :days

  with_options numericality:{other_than: 1} do
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :delivery_area_id
    validates :days_id
  end
end