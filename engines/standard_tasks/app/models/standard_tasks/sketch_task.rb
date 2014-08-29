module StandardTasks
  class SketchTask < ::Task
    title "Sketch Task"
    role "author"

    has_one :whiteboard_image, foreign_key: :task_id
  end
end
