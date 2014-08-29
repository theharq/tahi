module StandardTasks
  class SketchTaskSerializer < ::TaskSerializer
    has_one :whiteboard_image, embed: :id, include: true
  end
end
