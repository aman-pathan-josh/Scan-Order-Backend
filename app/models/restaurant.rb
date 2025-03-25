class Restaurant < ApplicationRecord
  has_many :menu_items,dependent: :destroy
  has_many :restaurant_tables,dependent: :destroy
  has_many :orders,dependent: :destroy
  has_many :user_restaurants,dependent: :destroy
  has_many :users, through: :user_restaurants

  validates :restaurant_name, :address, presence: true
  validates :contact, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "doesn't match valid format!" }
end
