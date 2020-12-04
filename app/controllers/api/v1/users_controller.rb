class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authorize!, except: :auto_login

  def create
    if (user = User.create(user_params)).valid?
      render json: user, scope: { token: create_token(user.id) }, status: 200
    else
      render json: { error: 'Invalid email or password' }, status: 409
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: user, scope: { token: create_token(user.id) }, status: 200
    else
      render json: { error: 'Invalid email or password' }, status: 401
    end
  end

  def auto_login
    render json: @current_user, status: 200
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def create_token(user_id)
    JvtCoder.encode({ user_id: user_id })
  end
end
