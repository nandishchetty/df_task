class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_signed_out_user

  def create
    user = User.where(email: params[:user][:email]&.downcase).first
    if user&.valid_password?(params[:user][:password])
      sign_in user, store: false
      render json: { email: user.email, auth_token: user.authentication_token }, status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    auth_token = request.headers['X-User-Token'].presence
    user_email = request.headers['X-User-Email'].presence
    user = user_email && User.find_by_email(user_email)
    if user && Devise.secure_compare(user.authentication_token, auth_token)
      user.renew_authentication_token
      sign_out
      head(:ok)
    else
      head(:unauthorized)
    end
  end

end
