module StandardTasks
  class SketchTask < Task
    title "Sketch Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
