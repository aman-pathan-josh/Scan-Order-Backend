module V1
  class MenuItemsController < AuthController
    skip_before_action :authenticate_request, only: [ :index ]
    def index
      if params[:restaurant_id].present?
        restaurant = Restaurant.find_by(id: params[:restaurant_id])

        if restaurant
          menu_items = restaurant.menu_items.with_attached_menu_image
          render json: menu_items.map { |menu_item|
            # review = Review.where(menu_item_id: menu_item.id).select(:rating)
            menu_item.as_json.merge(
              image_url: menu_item.menu_image.attached? ? url_for(menu_item.menu_image) : nil,
              reviews: menu_item.reviews
            )
          }, status: :ok
        else
          render json: { error: "Restaurant not found" }, status: :not_found
        end
      else
        render json: { error: "restaurant_id is required" }, status: :bad_request
      end
    end


    def show
      menu_item = MenuItem.find_by(id: params[:id])

      if menu_item
        render json: menu_item.as_json.merge(
          image_url: menu_item.menu_image.attached? ? url_for(menu_item.menu_image) : nil,
          reviews: menu_item.reviews
        ), status: :ok
      else
        render json: { error: "Menu item not found" }, status: :not_found
      end
    end

    private
    def menu_item_params
      params.require(:menu_item).permit(:restaurant_id, :item_name, :description, :price, :image_url)
    end
  end
end
