module StandardTasks
  class GraphvizTask < Task
    title "Graphviz Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
