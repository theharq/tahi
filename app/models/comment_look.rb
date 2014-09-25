class CommentLook < ActiveRecord::Base
  include EventStreamNotifier

  belongs_to :user, inverse_of: :comment_looks
  belongs_to :comment, inverse_of: :comment_look
  has_one :task, through: :comment

  private

  def notifier_payload
    { task_id: comment.task.id, paper_id: comment.task.paper.id }
  end
end
