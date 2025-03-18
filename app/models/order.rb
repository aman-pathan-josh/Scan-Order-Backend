class Order < ApplicationRecord
  belongs_to :restaurant_table
  belongs_to :user
  belongs_to :restaurant
  has_many :order_carts, dependent: :destroy
  has_many :menu_items, through: :order_carts

  validates :restaurant_table_id, presence: true
  validates :order_amount, :order_status, presence: true
end
