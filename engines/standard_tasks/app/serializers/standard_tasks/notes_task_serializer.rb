module StandardTasks
  class NotesTaskSerializer < ::TaskSerializer

    has_many :notes, include: true, root: :notes, embed: :ids

    def notes
      ::Note.order('created_at desc').all
    end
  end
end
