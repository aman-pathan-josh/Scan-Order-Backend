module V1
  class RestaurantTablesController < V1::BaseController
    def index
      @restaurant_tables = RestaurantTable.all
      render json: @restaurant_tables
    end

    def show
      @restaurant_table = RestaurantTable.find(params[:id])
      render json: @restaurant_table
    end

    def create
      @restaurant_table = RestaurantTable.new(restaurant_table_params)
      if @restaurant_table.save
        render json: @restaurant_table, status: :created
      else
        render json: @restaurant_table.errors, status: :unprocessable_entity
      end
    end

    def update
      @restaurant_table = RestaurantTable.find(params[:id])
      if @restaurant_table.update(restaurant_table_params)
        render json: @restaurant_table
      else
        render json: @restaurant_table.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @restaurant_table = RestaurantTable.find(params[:id])
      @restaurant_table.destroy
    end

    private
    def restaurant_table_params
      params.require(:restaurant_table).permit(:restaurant_id, :qr_code_url)
    end
  end
end
