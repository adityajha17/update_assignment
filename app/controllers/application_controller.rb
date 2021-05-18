# $user_secret_key = Rails.application.credentials.user_secret_key
# $admin_secret_key = Rails.application.credentials.admin_secret_key
class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def user_authenticate
    authorization_header = request.headers[:authorization]
    if !authorization_header
      render status: :unauthorized
    else
      token = authorization_header.split(" ")[1]
      user_secret_key = Rails.application.credentials.user_secret_key
      decoded_token = JWT.decode(token, user_secret_key)
      @user = User.find(decoded_token[0]["user_id"])
    end
  end

  def admin_authenticate
    authorization_header = request.headers[:authorization]
    if !authorization_header
      render status: :unauthorized
    else
      token = authorization_header.split(" ")[1]
      admin_secret_key = Rails.application.credentials.admin_secret_key
      
      decoded_token = JWT.decode(token, admin_secret_key)

      @admin = Admin.find(decoded_token[0]["admin_id"])
    end
  end
end
