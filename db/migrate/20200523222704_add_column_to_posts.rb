class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment, :text
    add_column :posts, :youtube_url, :text
    add_column :posts, :genre, :string
  end
end
