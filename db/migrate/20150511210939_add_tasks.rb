class AddTasks < ActiveRecord::Migration
  def change
      create_table :users do |t|
      t.string  :title
      t.text    :description
      t.string  :stage
      t.integer :project_id

      t.timestamps
    end
  end
end
