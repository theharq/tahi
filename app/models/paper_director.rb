class PaperDirector
  attr_reader :paper

  def initialize(paper)
    @paper = paper
  end

  def add_reviewers(user_ids)
    paper.transaction do
      user_ids.each do |id|
        PaperRole.reviewers_for(paper).where(user_id: id).create!
      end
      notify(:add_reviewers, user_ids)
    end
  end

  def remove_reviewers(user_ids)
    paper.transaction do
      PaperRole.reviewers_for(paper).where(user_id: user_ids).destroy_all
      notify(:remove_reviewers, user_ids)
    end
  end

  private

  def notify(message, *args)
    ReviewerReportTask.send(message.to_sym, self, *args)
  end

end
