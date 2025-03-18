class SuperAdmin::UsersController < SuperAdmin::BaseController
  before_action :authenticate_user!, :authorize_superadmin
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.update!(unconfirmed_email: params[:user][:email])
      @user.send_confirmation_instructions

      if @user.has_role?("superadmin")
        sign_out(@user)
      end

      redirect_to super_admin_users_path, notice: "User updated successfully."
    else
      render :edit, alert: "Failed to update user data!"
    end
  end

  def destroy
    if @user.user_roles.any?
      @user.user_roles.destroy_all
    end

    if @user.destroy
      redirect_to super_admin_users_path, notice: "User deleted successfully."
    else
      redirect_to super_admin_user_path(@user), alert: "Error deleting user."
    end
  end

  private

  def authorize_superadmin
    authorize! :manage, User
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, role_ids: [])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
