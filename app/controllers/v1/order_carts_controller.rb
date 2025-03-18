module V1
  class OrderCartsController < V1::BaseController
    def index
      @order_carts = OrderCart.all
      render json: @order_carts
    end

    def show
      @order_cart = OrderCart.find(params[:id])
      render json: @order_cart
    end

    def create
      @order_cart = OrderCart.new(order_cart_params)
      if @order_cart.save
        render json: @order_cart, status: :created
      else
        render json: @order_cart.errors, status: :unprocessable_entity
      end
    end

    def update
      @order_cart = OrderCart.find(params[:id])
      if @order_cart.update(order_cart_params)
        render json: @order_cart
      else
        render json: @order_cart.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @order_cart = OrderCart.find(params[:id])
      @order_cart.destroy
    end

    private
    def order_cart_params
      params.require(:order_cart).permit(:order_id, :menu_item_id, :quantity, :total_amount)
    end
  end
end
