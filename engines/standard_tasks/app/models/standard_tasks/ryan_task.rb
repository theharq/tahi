module StandardTasks
  class RyanTask < Task
    title "Ryan Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
