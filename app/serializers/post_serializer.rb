class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :category_id, :user_id
  # belongs_to :user, serializer: UserSerializer
  # belongs_to :category, serializer: CategorySerializer
end
