module PaperReviewers
  class Task < ::Task
    title 'Assign Reviewers'
    role 'editor'

    def permitted_attributes
      super + [{ reviewer_ids: [] }]
    end

    def array_attributes
      [:reviewer_ids]
    end

    def reviewer_ids=(user_ids)
      user_ids = user_ids.map(&:to_i)
      new_ids = user_ids - reviewer_ids
      old_ids = reviewer_ids - user_ids

      # TODO: need to handle this in a transaction
      director = PaperDirector.new(paper)
      director.add_reviewers(new_ids) unless new_ids.empty?
      director.remove_reviewers(old_ids) unless old_ids.empty?
    end

    def reviewer_ids
      paper.reviewers.pluck(:user_id)
    end

    def assignees
      journal.editors
    end

  end
end
