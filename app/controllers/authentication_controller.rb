class AuthenticationController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if !user
      render status: :unauthorized
    else
      if user.authenticate(params[:password]) 
        user_secret_key = Rails.application.credentials.user_secret_key
        token = JWT.encode({
                               user_id: user.id,
                               username: user.username
                           }, user_secret_key)
        render json: { token: token }

      else
        render status: :unauthorized

      end

    end
  end


end
