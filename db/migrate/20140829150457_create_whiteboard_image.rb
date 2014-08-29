class CreateWhiteboardImage < ActiveRecord::Migration
  def change
    create_table :standard_tasks_whiteboard_images do |t|
      t.references :task, index: true
      t.binary :data
    end
  end
end
