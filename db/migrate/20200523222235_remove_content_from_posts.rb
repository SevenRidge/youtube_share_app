class RemoveContentFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :content, :string
  end
end
