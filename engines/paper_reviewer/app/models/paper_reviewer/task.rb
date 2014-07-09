module PaperReviewer
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

      director = PaperDirector.new(paper)
      transaction do
        director.add_reviewers(new_ids) unless new_ids.empty?
        director.remove_reviewers(old_ids) unless old_ids.empty?
      end
    end

    def reviewer_ids
      paper.reviewers.pluck(:user_id)
    end

    def assignees
      journal.editors
    end
  end
end
