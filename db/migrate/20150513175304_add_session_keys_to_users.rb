class AddSessionKeysToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_keys, :string
  end
end
