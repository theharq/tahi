module StandardTasks
  class NotesTask < Task
    title "Notes Task"
    role "author"

    def active_model_serializer
      ::StandardTasks::NotesTaskSerializer
    end
  end
end
