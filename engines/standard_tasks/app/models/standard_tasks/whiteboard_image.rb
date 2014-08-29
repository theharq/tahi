module StandardTasks
  class WhiteboardImage < ActiveRecord::Base
    belongs_to :task, foreign_key: :task_id
  end
end
