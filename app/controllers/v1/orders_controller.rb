module V1
  class OrdersController < AuthController
    before_action :set_restaurant

    def index
      orders = current_user.orders
                           .where(restaurant: @restaurant)
                           .includes(order_carts: :menu_item)
                           .order(created_at: :desc)

      render json: orders.as_json(include: { order_carts: { include: :menu_item } }), status: :ok
    end

    def create
      restaurant_table = @restaurant.restaurant_tables.find_by(id: params[:restaurant_table_id])
      return render json: { error: "Invalid restaurant_table_id!" }, status: :unprocessable_entity unless restaurant_table

      order = current_user.orders.create!(
        restaurant: @restaurant,
        restaurant_table: restaurant_table,
        order_status: "pending",
        order_amount: params[:order_amount]
      )

      order.order_carts.create!(params[:menu_items].map do |item|
        { menu_item_id: item[:menu_item_id], quantity: item[:quantity], total_amount: item[:total_price] }
      end)

      render json: { message: "Order placed successfully", order_id: order.id }, status: :created
    end

    def show
      order = current_user.orders.includes(order_carts: :menu_item)
                           .find_by(id: params[:id], restaurant: @restaurant)

      return render json: { error: "Order not found" }, status: :not_found unless order

      render json: order.as_json(include: { order_carts: { include: :menu_item } }), status: :ok
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
  end
end
