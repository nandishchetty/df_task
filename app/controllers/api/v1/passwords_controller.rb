class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json

  def reset_password
    user = User.find_by(email: params[:email])
    if user
      user.send_reset_password_instructions
      render json: { message: 'Password recovery link sent', success: true }, status: :accepted
    else
      render json: { message: 'Email does not exist', success: false }, status: :unprocessable_entity
    end
  end

  def update
    # there may be a better way of doing this, devise should be able to give us these messages
    self.resource = resource_class.reset_password_by_token(resource_params)
    if self.resource.errors.empty?
      self.resource.renew_authentication_token
      render json: { message: 'Password reset successfully', success: true }, status: :accepted
    else
      render json: { message: resource.errors.full_messages.join(', '), success: false }, status: :unprocessable_entity
    end
  end

end
