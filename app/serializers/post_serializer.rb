class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :category_id, :user_id
end
