module VideoCard
	class Task < :: Task
	  title "video card"
	  role "author"

	  def active_model_serializer
	    ::VideoCard::TaskSerializer
	  end
	end
end
