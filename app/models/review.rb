class Review < ApplicationRecord
  belongs_to :menu_item
  belongs_to :user

  validates :rating, :comment, presence: true
end
