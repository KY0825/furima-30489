class Item < ApplicationRecord
  validates :image,               presence: true
  validates :name,                presence: true
  validates :text,                presence: true
  validates :category_id,         presence: true
  validates :status_id,           presence: true
  validates :delivery_charge_id,  presence: true
  validates :delivery_area_id,    presence: true
  validates :days_id,             presence: true
  validates :price,               presence: true, format: { with: /\A[0-9]+\z/} do   #minimumとmaximum
  end
  validates :user,                presence: true
end


