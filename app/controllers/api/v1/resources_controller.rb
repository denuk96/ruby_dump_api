class Api::V1::ResourcesController < Api::V1::ApiController
  skip_before_action :authorize_user!

  def load
    posts = Post.all.order(created_at: :desc)
    categories = Category.all

    render json: {
      categories: ActiveModelSerializers::SerializableResource.new(categories, each_serializer: CategorySerializer)
                                                              .serializable_hash,
      posts: ActiveModelSerializers::SerializableResource.new(posts, each_serializer: PostSerializer)
                                                         .serializable_hash
    }, status: 200
  end
end
