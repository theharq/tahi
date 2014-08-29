module StandardTasks
  class WhiteboardImageSerializer < ActiveModel::Serializer
    attributes :data
    has_one :task, embed: :ids
  end
end
