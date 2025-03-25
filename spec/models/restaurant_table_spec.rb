require 'rails_helper'
require 'rqrcode'

RSpec.describe RestaurantTable, type: :model do
  describe 'asscociation' do
    it { should belong_to :restaurant }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_one_attached(:qrcode) }
  end

  describe '#generate_qr_code' do
    let(:restaurant) { create(:restaurant) }
    let(:restaurant_table) { create(:restaurant_table, restaurant: restaurant) }

    it 'generates a QR code and attaches it to the restaurant table' do
      expect(restaurant_table.qrcode).not_to be_attached

      restaurant_table.generate_qr_code

      expect(restaurant_table.qrcode).to be_attached
      expect(restaurant_table.qrcode.filename.to_s).to eq("table_#{restaurant_table.id}_qrcode.png")
      expect(restaurant_table.qrcode.content_type).to eq('image/png')
    end
  end
end
