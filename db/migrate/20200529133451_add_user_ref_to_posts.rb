class AddUserRefToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, foreign_key: true, null: false
  end
  add_index :posts, [:user_id, :created_at]
end
