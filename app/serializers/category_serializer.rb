class CategorySerializer < ActiveModel::Serializer
  attributes :name
  has_many :posts, serializer: PostSerializer
end
