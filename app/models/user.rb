class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,         presence: true
  validates :password,         presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX 
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/} do
  validates :first_name
  validates :last_name
  end
  with_options presence: true, format: { with: /\A[ァ-ン]+\z/} do
  validates :first_name_kana
  validates :last_name_kana
  end
  validates :birthday,         presence: true

  has_many :order
  has_many :item

end
