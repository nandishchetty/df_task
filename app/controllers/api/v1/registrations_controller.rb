class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(user_params)
    if resource.save
      if resource.active_for_authentication?
        sign_in(resource)
        response.headers['X-User-Token'] = resource.authentication_token
        response.headers['X-User-Email'] = resource.email
        return render json: { user: { email: resource.email, authentication_token: resource.authentication_token } }, status: :created
      else
        expire_session_data_after_sign_in!
        return render json: { success: true }
      end
    else
      clean_up_passwords resource
      return render status: :unprocessable_entity, json: { user: { errors: resource.errors.full_messages, success: false } }
    end
  end

  protected

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :role)
  end
end
