class AddProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string  :title
      t.integer :owner_id

      t.timestamps
    end
  end
end
