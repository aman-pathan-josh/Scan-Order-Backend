class SuperAdmin::BaseController < ApplicationController
  private
  def ensure_superadmin
    unless current_user.has_role?("superadmin")
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
