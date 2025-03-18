module V1
  class ReviewsController < AuthController
    before_action :set_review, only: [ :update, :destroy ]

    def index
      menu_item = MenuItem.find_by(id: params[:menu_item_id])

      if menu_item
        reviews = menu_item.reviews.includes(:user)
        render json: reviews.as_json(
          except: [ :user_id ],
          include: { user: { only: [ :id, :first_name, :last_name ] } }
        ), status: :ok
      else
        render json: { error: "Menu item not found" }, status: :not_found
      end
    end

    def create
      review = Review.new(review_params)
      review.user_id = current_user.id

      if review.save
        render json: review, status: :created
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @review.user_id == current_user.id
        if @review.update(review_params)
          render json: @review, status: :ok
        else
          render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "You can only update your own review" }, status: :forbidden
      end
    end

    def destroy
      if @review.user_id == current_user.id
        @review.destroy
        render json: { message: "Review deleted successfully" }, status: :ok
      else
        render json: { error: "You can only delete your own review" }, status: :forbidden
      end
    end

    private

    def set_review
      @review = Review.find_by(id: params[:id])
      render json: { error: "Review not found" }, status: :not_found unless @review
    end

    def review_params
      params.permit(:menu_item_id, :rating, :comment)
    end
  end
end
