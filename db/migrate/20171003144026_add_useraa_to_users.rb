class AddUseraaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :useraa, :string
  end
end
