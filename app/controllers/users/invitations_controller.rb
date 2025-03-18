class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!, except: [ :edit, :update ]
  before_action :authorize_superadmin, except: [ :edit, :update ]

  def update
    @user = User.accept_invitation!(invite_params)
    if @user.errors.empty?
      redirect_to root_path, notice: "Your password has been set. You can now log in."
    else
      render :edit
    end
  end

  private

  def authorize_superadmin
    unless current_user.has_role?("superadmin")
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def invite_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :invitation_token)
  end
end
