class CreateRestaurantTables < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurant_tables do |t|
      t.references :restaurant, foreign_key: true
      t.string :qr_code_url
      t.timestamps
    end
  end
end
