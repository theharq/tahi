module StandardTasks
  class WhiteboardImageSerializer < ActiveModel::Serializer
    attributes :data, :id
    has_one :task, embed: :id, polymorphic: true
  end
end
