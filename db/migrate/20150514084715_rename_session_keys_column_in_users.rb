class RenameSessionKeysColumnInUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :session_keys
      t.string :session_key
    end
  end
end
