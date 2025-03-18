# class V1::BaseController < ApplicationController
#   skip_before_action :verify_authenticity_token
#   include JsonWebToken

#   before_action :authenticate_request

#   private

#   def authenticate_request
#     header = request.headers["Authorization"]
#     if header.present?
#       token = header.split(" ").last
#       decoded = jwt_decode(token)
#       @current_user = User.find(decoded[:user_id]) if decoded
#     end

#     render json: { error: "Not Authorized" }, status: :unauthorized unless @current_user
#   end
# end
