class ApiController < ActionController::API
  respond_to :json

  rescue_from Exception, with: :handle_api_exceptions

  def api_controller?
    true
  end

  private

  def respond_with_error_for_record_not_found(message)
    # 404 status code
    respond_with_error(message, :not_found)
  end

end
