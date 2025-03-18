require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'assocciations' do
    it { should have_many(:menu_items) }
    it { should have_many(:restaurant_tables) }
    # it { should have_many(:orders) }
    it { should have_many(:user_restaurants) }
    it { should have_many(:users).through(:user_restaurants) }
  end

  describe 'validations' do
    subject { build(:restaurant) }
    it { should validate_presence_of(:restaurant_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:contact) }
    it { should validate_uniqueness_of(:contact).case_insensitive }
    it { should allow_value('1234567890').for(:contact) }
    it { should_not allow_value('12345').for(:contact) }
  end
end
