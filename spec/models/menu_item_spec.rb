require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:order_carts) }
    it { should have_many(:orders).through(:order_carts) }
    it { should have_one_attached(:image) }
  end
  describe 'validations' do
    it { should validate_presence_of(:item_name) }
    it { should validate_presence_of(:price) }
  end
end
