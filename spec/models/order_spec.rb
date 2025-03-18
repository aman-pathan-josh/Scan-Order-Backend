require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:restaurant_table) }
    it { should belong_to(:user) }
    it { should have_many(:order_carts).dependent(:destroy) }
    it { should have_many(:menu_items).through(:order_carts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:restaurant_table_id) }
    it { should validate_presence_of(:order_amount) }
  end
end
