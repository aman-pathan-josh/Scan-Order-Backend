class SuperAdmin::DashboardController < SuperAdmin::BaseController
  before_action :authenticate_user!
  load_and_authorize_resource class: false

  def index
    @users = User.all
    @restaurants = Restaurant.all
    @orders = Order.all
    @total_users = @users.count
    @total_restaurants = @restaurants.count
    @total_orders = @orders.count
    @menu_items = MenuItem.all
    @reviews = Review.all
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to access this page."
  end
end
