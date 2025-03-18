class RemoveQrCodeUrlFromRestaurantTables < ActiveRecord::Migration[7.2]
  def change
    remove_column :restaurant_tables, :qr_code_url, :string
  end
end
