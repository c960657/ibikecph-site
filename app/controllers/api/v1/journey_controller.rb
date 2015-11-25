class Api::V1::JourneyController < Api::V1::BaseController
  skip_before_filter :check_auth_token!

  rescue_from TravelPlanner::Error, with: :error_message
  rescue_from StandardError, with: :standard_message

  def show
    render json: TravelPlanner.get_journey(params[:loc])
  end

  def error_message(e)
    render json: {error: e.message}, status: 422
  end

  def standard_message(e)
    ExceptionNotifier.notify_exception(e)
    render json: {error: 'An unexpected error occurred.'}, status: 500
  end
end