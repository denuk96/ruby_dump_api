class Api::V1::PostsController < Api::V1::ApiController
  skip_before_action :authorize!, only: %i[index show]
  load_and_authorize_resource find_by: :id, class: :Post, except: %i[index create]

  def index
    post = Post.order(created_at: :desc)

    render json: post, status: :ok
  end

  def create
    post = @current_user.posts.build(post_params)
    if post.save
      render json: post, serializer: PostSerializer, status: :created
    else
      render json: { post_errors: post.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @post, status: :ok
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { errors: @post.errors.messages }, status: 422
    end
  end

  def destroy
    if @post.destroy
      render json: {}, status: :no_content
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.permit(:title, :body, :category_id)
  end
end
