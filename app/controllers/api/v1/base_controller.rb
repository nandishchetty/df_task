class Api::V1::BaseController < ApiController

  # acts_as_token_authentication_handler_for User, fallback: :exception

  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    auth_token = request.headers['X-User-Token'].presence
    user_email = request.headers['X-User-Email'].presence
    user = user_email && User.find_by_email(user_email)
    if user && Devise.secure_compare(user.authentication_token, auth_token)
      @current_user = user
    else
      head(:unauthorized)
    end
  end

  protected

  def authorize_user
    authorize current_user, :regular_user?
  end

  private

  def user_not_authorized
    head(:unprocessable_entity)
  end

end
