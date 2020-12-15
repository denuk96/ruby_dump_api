class PostSerializer < ActiveModel::Serializer
  belongs_to :category
  attributes :id, :title, :body, :category_id, :user_id
end
