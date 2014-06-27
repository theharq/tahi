class ReviewerReportTask < Task
  def permitted_attributes
    super + [{paper_review_attributes: [:body, :id]}]
  end

  title 'Reviewer Report'
  role 'reviewer'

  has_one :paper_review, foreign_key: 'task_id'

  accepts_nested_attributes_for :paper_review

  def assignees
    journal.reviewers
  end

  def destroy
    self.transaction do
      if assignee.present?
        assignee.paper_roles.where(paper: paper, reviewer: true).destroy_all
      end
      super
    end
  end

  #TODO: decide if we should notify when new tasks are created
  def self.add_reviewers(director, user_ids)
    phase = default_phase(director.paper)
    user_ids.map do |user_id|
      create! phase: phase, assignee_id: user_id
    end
  end

  #TODO: decide if we should notify when new tasks are destroyed
  def self.remove_reviewers(director, user_ids)
    director.paper.tasks.where(type: name, assignee_id: user_ids).destroy_all
  end

  def self.default_phase(paper)
    paper.phases.last

    #TODO figure out how to determine correct phase
    # get_reviews_phase = paper.phases.where(name: 'Get Reviews').first
    # get_reviews_phase || phase_of_assign_reviewer_task
  end
end
