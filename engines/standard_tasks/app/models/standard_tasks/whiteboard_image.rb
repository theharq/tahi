module StandardTasks
  class WhiteboardImage < ActiveRecord::Base
    belongs_to :task
  end
end
