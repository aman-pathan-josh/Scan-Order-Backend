class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :menu_item, foreign_key: true
      t.float :rating
      t.text :comment
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
