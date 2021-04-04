class RenamePostColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :pictures, :picture
  end
end
