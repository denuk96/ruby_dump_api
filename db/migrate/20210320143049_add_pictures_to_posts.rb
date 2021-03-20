class AddPicturesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :pictures, :text
  end
end
