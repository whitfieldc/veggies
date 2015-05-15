class CreateTagsTasks < ActiveRecord::Migration
  def change
    create_table :tagstasks do |t|
      t.integer :tag_id
      t.integer :task_id

      t.timestamps
    end
  end
end
