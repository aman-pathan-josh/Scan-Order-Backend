class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :restaurant_table, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :order_amount
      t.string :order_status
      t.timestamps
    end
  end
end
