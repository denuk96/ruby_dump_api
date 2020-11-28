class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authorize!

  def create
    if (user = User.create(user_params)).valid?
      token = JvtCoder.encode({ user_id: user.id })

      render json: { user: user, token: token }, status: 200
    else
      render json: { error: 'Invalid email or password' }, status: 409
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end