class RestaurantTable < ApplicationRecord
  belongs_to :restaurant
  has_many :orders, dependent: :destroy
  has_one_attached :qrcode, dependent: :destroy

  def generate_qr_code
    qr = RQRCode::QRCode.new("http://localhost:5173/menu?restaurant_id=#{restaurant.id}&restaurant_table_id=#{id}")
    png = qr.as_png(size: 300)

    qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: "table_#{id}_qrcode.png",
      content_type: "image/png"
    )
  end
end
