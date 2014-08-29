module StandardTasks
  class NgramsTask < Task
    title "Ngrams Task"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
