class Api::V1::ApiController < ActionController::API
  before_action :authorize!

  private

  def authorize!
    unless (@current_user = JvtAuthorize.new(request.headers['Authorization']).authorize)
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
