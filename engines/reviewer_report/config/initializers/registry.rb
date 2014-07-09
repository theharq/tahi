TahiRegistry.subscribe('paper:add_reviewers', ReviewerReport::Task, :add_reviewers)
TahiRegistry.subscribe('paper:remove_reviewers', ReviewerReport::Task, :remove_reviewers)
