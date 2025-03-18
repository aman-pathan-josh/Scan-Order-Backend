class Admin::MenuItemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_menu_item, only: [ :show, :edit, :update, :destroy ]
  before_action :set_restaurant, only: [ :index, :new, :create, :update ]

  def index
    @menu_items = @restaurant.menu_items
  end

  def show
  end

  def new
    @menu_item = @restaurant.menu_items.new
  end

  def create
    @menu_item = @restaurant.menu_items.new(menu_item_params)

    if @menu_item.save
      redirect_to admin_restaurant_menu_items_path(@restaurant), notice: "Menu item was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @restaurant = @menu_item.restaurant

    if @menu_item.update(menu_item_params)
      redirect_to admin_restaurant_menu_items_path(@restaurant), notice: "Menu Item was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @menu_item.destroy
      redirect_to admin_restaurant_menu_items_path(@menu_item.restaurant), notice: "Menu item was successfully deleted."
    else
      redirect_to admin_restaurant_menu_items_path
    end
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find_by(id: params[:id], restaurant_id: current_user.restaurants.pluck(:id))
    if @menu_item
      @restaurant = @menu_item.restaurant
    else
      redirect_to admin_restaurant_menu_items_path, alert: "Not authorized to access this menu item." unless @menu_item
    end
  end

  def set_restaurant
    @restaurant = current_user.restaurants.find_by(id: params[:restaurant_id])
    redirect_to admin_restaurants_path, alert: "Not authorized to access this restaurant." unless @restaurant
  end

  def menu_item_params
    params.require(:menu_item).permit(:item_name, :description, :price, :menu_image)
  end
end
