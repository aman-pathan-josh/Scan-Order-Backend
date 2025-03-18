require 'rails_helper'

RSpec.describe OrderCart, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:menu_item) }
  end
end
