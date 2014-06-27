module PaperReviewers
  class TaskSerializer < ::TaskSerializer
    embed :ids
    has_many :journal_reviewers, serializer: UserSerializer, include: true, root: :users
    has_many :reviewers, serializer: UserSerializer, include: true, root: :users

    def journal_reviewers
      object.journal.reviewers
    end

    def reviewers
      object.paper.reviewers
    end
  end
end
