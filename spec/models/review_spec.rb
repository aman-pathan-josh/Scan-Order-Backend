
RSpec.describe Review, type: :model do
  describe 'associations' do
    it { should belong_to(:menu_item) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:comment) }
    it { should validate_presence_of(:rating) }
  end
end

class Review < ApplicationRecord
  belongs_to :menu_item
  belongs_to :user

  validates :rating, :comment, presence: true
end
