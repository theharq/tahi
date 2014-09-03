module StandardTasks
  class MapTask < Task
    title "Map Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
