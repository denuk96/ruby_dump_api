class Api::V1::PostsController < Api::V1::ApiController
  skip_before_action :authorize!, only: :index

  def index
    post = Post.preload(:category).order(created_at: :desc)
    render json: post, status: :ok
  end

  def create
    if (post = @current_user.posts.create(post_params)).valid?
      render json: post, status: :ok
    else
      render json: { errors: post.errors.messages },
             status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :body, :category_id, :user_id)
  end
end
