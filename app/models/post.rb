# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  body        :text
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
class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user

  validates_presence_of :title, :body
  validates_uniqueness_of :title
  validates :title, length: 3..40
  validates :body, length: { minimum: 5}
end
