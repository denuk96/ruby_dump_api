class Api::V1::ApiController < ActionController::API
  before_action :authorize_user!

  def authorize_user!
    unless (@current_user = JvtAuthorizer.new(request.headers["Authorization"]).authorize)
      render json: { message: "You have to authenticate to access this page." }, status: 401
    end
  end

  # overrides default current_user method to @current_user object
  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end

  # handle unauthorized access
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: "Access denied" }, status: 403
  end
end
