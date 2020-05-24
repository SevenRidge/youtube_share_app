class RenameContentColumsToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :content, :comment
  end
end
