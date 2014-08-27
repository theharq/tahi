module VideoCard
  class Task < ::Task
    title "Video Card"
    role "author"

    def active_model_serializer
      ::VideoCard::TaskSerializer
    end
  end
end
