class SuperAdmin::RestaurantsController < SuperAdmin::BaseController
  before_action :authenticate_user!
  before_action :ensure_superadmin

  def index
    @restaurants = Restaurant.includes(:restaurant_tables, :menu_items, :orders)
    @menu_items = MenuItem.includes(:reviews) # Preload reviews for menu items
  end
end
