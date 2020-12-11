class Api::V1::ApiController < ActionController::API
  before_action :authorize!

  private
  def authorize!
    unless (@current_user = JvtAuthorizer.new(request.headers["Authorization"]).authorize)
      render json: { message: "You have to authenticate to access this page." }, status: :unprocessable_entity
    end
  end
end
