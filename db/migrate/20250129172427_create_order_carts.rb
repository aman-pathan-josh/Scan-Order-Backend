class CreateOrderCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :order_carts do |t|
      t.references :order, foreign_key: true
      t.references :menu_item, foreign_key: true
      t.integer :quantity
      t.decimal :total_amount
      t.timestamps
    end
  end
end
