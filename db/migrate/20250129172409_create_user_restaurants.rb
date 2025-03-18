class CreateUserRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :user_restaurants, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.timestamps
    end
  end
end
