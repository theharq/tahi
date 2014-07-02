Bus.subscribe('paper:add_reviewers', ReviewerReportTask, :add_reviewers)
Bus.subscribe('paper:remove_reviewers', ReviewerReportTask, :remove_reviewers)
Bus.subscribe('author:create', FinancialDisclosure::Task, :author_created)
