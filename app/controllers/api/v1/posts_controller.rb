class Api::V1::PostsController < Api::V1::ApiController
  before_action :set_post, only: %i[update destroy]

  def index
    render json: { posts: Post.order(created_at: :desc) }, status: :ok
  end

  def create
    post = @current_user.posts.build(post_params)
    if post.save
      render json: post, serializer: PostSerializer, status: :created
    else
      render json: { post_errors: post.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, serializer: PostSerializer, status: :ok
    else
      render json: { errors: @post.errors.messages }, status: :unprocessable_entity
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
    params.permit(:title, :body, :category_id, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
