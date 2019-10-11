class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_parameters_rescue

  def unpermitted_parameters_rescue(exception)
    logger.info("#{exception.class}: " + exception.message)
    if Rails.env.development?
      render json: { message: exception, backtrace: exception.backtrace }, status: :not_found
    else
      render json: { message: exception, status: 500 }, status: :not_found
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_rescue

  def routing_error(error = "Routing error", status = :not_found, exception = nil)
    render json: { message: error, status: 404 }, status: :not_found
  end

  def posting_error(error = "You are not allowed alter records", status = :not_found, exception = nil)
    render json: { message: error, status: 404 }, status: :not_found
  end

  def record_not_found_rescue(exception)
    logger.info("#{exception.class}: " + exception.message)
    if Rails.env.development?
      render json: { message: exception, status: 404 }, status: :not_found
    else
      render json: { message: exception, backtrace: exception.backtrace }, status: :not_found
    end
  end
end
