class Admin::ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :set_review, only: [ :destroy ]
  before_action :set_menu_item
  def index
    @reviews = @menu_item.reviews
  end

  def show
  end

  # def new
  #   @restaurant_table = @restaurant.restaurant_tables.new
  # end

  # def create
  #   @restaurant_table = @restaurant.restaurant_tables.create(restaurant_table_params)

  #   if @restaurant_table.save
  #     redirect_to admin_restaurant_restaurant_tables_path(@restaurant_table), notice: "Table was successfully created."
  #   else
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update
  #   if @restaurant_table.update(restaurant_table_params)
  #     redirect_to admin_restaurant_restaurant_table_path(@restaurant), notice: "Table was successfully updated."
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @review.destroy
    redirect_to admin_restaurant_menu_item_reviews_path, notice: "Restaurant was successfully deleted."
  end

  private

  def set_review
    @review = Review.find_by(id: params[:id])
  end

  def set_menu_item
    @menu_item = MenuItem.find(params[:menu_item_id])
  end
end
