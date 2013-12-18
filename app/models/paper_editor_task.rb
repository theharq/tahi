class PaperEditorTask < Task
  PERMITTED_ATTRIBUTES = [{ paper_role_attributes: [:user_id] }]

  title 'Assign Editor'
  role 'admin'

  def paper_role
    PaperRole.where(paper: paper, editor: true).first_or_initialize
  end

  def paper_role_attributes=(attributes)
    paper_role.update attributes
  end
end
