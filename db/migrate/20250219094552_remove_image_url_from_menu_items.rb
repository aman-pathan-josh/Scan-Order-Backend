class RemoveImageUrlFromMenuItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :menu_items, :image_url, :string
  end
end
