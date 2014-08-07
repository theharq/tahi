class QuestionAttachmentsPolicy < ApplicationPolicy
  require_params :task

  def destroy?
    current_user.admin? || task_owner? || metadata_task_collaborator? || has_sufficient_role?
  end

  private

  def task_owner?
    current_user.tasks.where(id: task.id).first
  end

  def metadata_task_collaborator?
    task.is_metadata? && task.paper.collaborators.exists?(current_user)
  end

  def has_sufficient_role?
    current_user.roles.where(journal_id: task.journal.id, can_view_all_manuscript_managers: true).exists?
  end
end