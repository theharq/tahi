module StandardTasks
  class TutorialTask < Task
    title "Tutorial Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
