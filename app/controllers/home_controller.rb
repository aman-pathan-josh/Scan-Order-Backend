class HomeController < ApplicationController
  def index
    @restaurant_count = Restaurant.count
    @users_count = User.count
    render
  end
end
