class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  private

  def check_admin
    unless current_user.has_role?("admin")
      flash[:alert] = "You are not authorized to access this area"
      redirect_to root_path
    end
  end
end
