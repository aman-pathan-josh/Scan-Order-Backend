class Admin::OrdersController < ApplicationController
  before_action :set_restaurant
  before_action :set_order, only: [ :show, :update, :destroy ]

  def index
    @orders = @restaurant.orders.includes(:order_carts, :restaurant_table)
    render :index
  end

  def show
    render :show
  end

  def update
    if @order.update(order_params)
      redirect_to admin_restaurant_orders_path(@restaurant), notice: "Order updated successfully."
    else
      flash.now[:alert] = "Failed to update order."
      render :show  # Stay on the same page if validation fails
    end
  end

  def destroy
    if @order.destroy
      redirect_to admin_restaurant_orders_path(@restaurant), notice: "Order deleted successfully."
    else
      redirect_to admin_restaurant_orders_path(@restaurant), alert: "Failed to delete order."
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_order
    @order = @restaurant.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
