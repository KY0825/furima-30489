class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  validates :image,               presence: true
  validates :name,                presence: true
  validates :text,                presence: true
  validates :category_id,         presence: true
  validates :status_id,           presence: true
  validates :delivery_charge_id,  presence: true
  validates :delivery_area_id,    presence: true
  validates :days_id,             presence: true
  validates :price,               presence: true,:numericality => { only_interger: true,:greater_than_or_equal_to => 300,:less_than_or_equal_to => 9_999_999 },format: { with: /\A[0-9]+\z/} do
  end
  validates :user,                presence: true
  has_one_attached :image

  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_area
  belongs_to_active_hash :days

  validates :category_id, numericality: { other_than: 1 } 
  validates :status_id, numericality: { other_than: 1 } 
  validates :delivery_charge_id, numericality: { other_than: 1 } 
  validates :delivery_area_id, numericality: { other_than: 1 } 
  validates :days_id, numericality: { other_than: 1 } 

end