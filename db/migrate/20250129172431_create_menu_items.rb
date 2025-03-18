class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.references :restaurant, foreign_key: true
      t.string :item_name
      t.text :description
      t.decimal :price
      t.string :image_url
      t.timestamps
    end
  end
end
