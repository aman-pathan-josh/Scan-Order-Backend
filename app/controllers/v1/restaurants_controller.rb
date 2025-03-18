module V1
  class RestaurantsController < V1::BaseController
    def index
      @restaurants = Restaurant.all
      render json: @restaurants
    end

    def show
      @restaurant = Restaurant.find(params[:id])
      render json: @restaurant
    end

    def create
      @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        render json: @restaurant, status: :created
      else
        render json: @restaurant.errors, status: :unprocessable_entity
      end
    end

    def update
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.update(restaurant_params)
        render json: @restaurant
      else
        render json: @restaurant.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
    end

    private
    def restaurant_params
      params.require(:restaurant).permit(:restaurant_name, :address, :contact)
    end
  end
end
