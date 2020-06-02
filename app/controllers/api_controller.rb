class ApiController < ActionController::API
  respond_to :json

  rescue_from Exception, with: :handle_api_exceptions

  def api_controller?
    true
  end

  private

  def handle_api_exceptions exception
    log_exception exception

    message = exception.message || 'Something went wrong. Please try again later.'
    if exception.is_a?(ActiveRecord::RecordNotFound)
      respond_with_error_for_record_not_found(message)
      # elsif exception.is_a?(Pundit::NotAuthorizedError)
      #   respond_with_error_for_authorization(exception.safe_message.capitalize)
    else
      respond_with_error(message)
    end
  end


  def respond_with_error_for_record_not_found(message)
    # 404 status code
    respond_with_error(message, :not_found)
  end

  def respond_with_error(message, status = 500, errors = {}, error_code = nil, response_body = {})
    response_body[:message] = message
    response_body[:error_code] = error_code unless error_code.nil?
    response_body[:errors] = errors if errors.present?

    render json: response_body, status: status
  end

  def log_exception exception
    Rails.logger.info exception.class.to_s
    Rails.logger.info exception.to_s
    Rails.logger.info exception.backtrace.join("\n")
  end

end
