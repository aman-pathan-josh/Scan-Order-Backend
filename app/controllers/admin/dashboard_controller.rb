class Admin::DashboardController < Admin::BaseController
  def index
    @total_restaurants = current_user.restaurants.count
    @restaurants = current_user.restaurants
    @total_orders = Order.count
  end
end
