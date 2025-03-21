require 'rails_helper'

RSpec.describe UserRestaurant, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:restaurant) }
  end
end
