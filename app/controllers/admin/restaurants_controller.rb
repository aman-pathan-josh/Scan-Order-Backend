class Admin::RestaurantsController < Admin::BaseController
  load_and_authorize_resource
  before_action :set_restaurant, only: [ :show, :edit, :update, :destroy ]

  def index
    @restaurants = current_user.restaurants
  end

  def show
    @restaurant_tables_count = @restaurant.restaurant_tables.count
  end

  def new
    @restaurant = current_user.restaurants.new
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)

    if @restaurant.save
      redirect_to admin_restaurant_path(@restaurant), notice: "Restaurant was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurant_path(@restaurant), notice: "Restaurant was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path, notice: "Restaurant was successfully deleted."
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:restaurant_name, :address, :contact)
  end
end
