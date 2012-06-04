class AddSaltToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :salt, :string
    add_index   :users, :salt
  end
end
