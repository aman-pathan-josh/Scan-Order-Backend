class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.has_role?("admin")
      admin_dashboard_path
    elsif resource.has_role?("superadmin")
      super_admin_dashboard_path
    else
      root_path
    end
  end
end
