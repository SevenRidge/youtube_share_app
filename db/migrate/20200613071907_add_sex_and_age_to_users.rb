class AddSexAndAgeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sex, :string
    add_column :users, :age, :string
  end
end
