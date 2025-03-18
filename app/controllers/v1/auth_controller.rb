module V1
  class AuthController < ApplicationController
    include JsonWebToken
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_request, except: [ :signin, :signup ]

    def signin
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password])
        token = jwt_encode(user_id: user.id)
        render json: { user: user, token: token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    def signup
      user = User.new(signup_params)
      if user.save
        user.skip_confirmation_for_api!
        token = jwt_encode(user_id: user.id)
        render json: { user: user, token: token }, status: :created
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def authenticate_request
      header = request.headers["Authorization"]
      return render json: { error: "Not Authorized" }, status: :unauthorized unless header.present?

      token = header.split(" ").last
      decoded = jwt_decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded

      render json: { error: "Not Authorized" }, status: :unauthorized unless @current_user
    end

    def signup_params
      params.permit(:email, :first_name, :last_name, :phone_number, :password, :password_confirmation)
    end
  end
end
