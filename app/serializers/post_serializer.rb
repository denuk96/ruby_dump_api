# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  body        :text
#  pictures    :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_user_id      (user_id)
#
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :category_id, :user_id
  # belongs_to :user, serializer: UserSerializer
  # belongs_to :category, serializer: CategorySerializer
end
