class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name
      t.string :address
      t.string :contact
      t.timestamps
    end
  end
end
