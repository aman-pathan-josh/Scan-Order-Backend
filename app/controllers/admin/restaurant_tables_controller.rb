class Admin::RestaurantTablesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_restaurant_table, only: [ :show, :edit, :update, :destroy, :generate_qr ]
  before_action :set_restaurant, only: [ :index, :new, :create, :update ]

  def index
    @restaurant_tables = @restaurant.restaurant_tables
  end

  def show
  end

  def new
    @restaurant_table = @restaurant.restaurant_tables.new
  end

  def create
    @restaurant_table = @restaurant.restaurant_tables.create
    if @restaurant_table.persisted?
      @restaurant_table.generate_qr_code
      redirect_to admin_restaurant_restaurant_tables_path(@restaurant), notice: "Table added successfully!"
    else
      redirect_to admin_restaurant_restaurant_tables_path(@restaurant), alert: "Failed to add table."
    end
  end

  def edit
  end

  def update
    if @restaurant_table.update(restaurant_table_params)
      redirect_to admin_restaurant_restaurant_table_path(@restaurant_table.restaurant_id, @restaurant_table), notice: "Table was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path, notice: "Restaurant was successfully deleted."
  end

  def generate_qr
    @restaurant_table.generate_qr_code
    redirect_to admin_restaurant_restaurant_table_path, notice: "QR Code generated successfully."
  end

  private

  def set_restaurant_table
    @restaurant_table = RestaurantTable.find_by(id: params[:id], restaurant_id: current_user.restaurants.pluck(:id))
    if @restaurant_table
      @restaurant = @restaurant_table.restaurant
    else
      redirect_to admin_restaurant_restaurant_table_path, alert: "Not authorized to access this menu item." unless @menu_item
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def restaurant_table_params
    params.require(:restaurant_table).permit(:qrcode)
  end
end
