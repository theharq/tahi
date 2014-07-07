module ReviewerReport
  class TaskSerializer < ::TaskSerializer
    has_one :paper_review, embed: :id
  end
end
