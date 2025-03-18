class AddRestaurantIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :restaurant_id, :integer
  end
end
