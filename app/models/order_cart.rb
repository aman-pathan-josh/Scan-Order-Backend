class OrderCart < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
end
