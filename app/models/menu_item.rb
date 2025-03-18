class MenuItem < ApplicationRecord
  has_one_attached :menu_image
  belongs_to :restaurant
  has_many :reviews, dependent: :destroy
  has_many :order_carts
  has_many :orders, through: :order_carts

  validates :item_name, :price, presence: true
end
