require 'spec_helper'

feature "Reviewer Report", js: true do
  let(:journal) { FactoryGirl.create :journal }

  let!(:reviewer) { FactoryGirl.create :user }

  let!(:paper) do
    FactoryGirl.create(:paper, :with_tasks, user: reviewer, journal: journal, submitted: true)
  end

  before do
    assign_journal_role(journal, reviewer, :reviewer)
    paper_reviewer_task = paper.phases.where(name: 'Assign Reviewers').first.tasks.where(type: 'StandardTasks::PaperReviewerTask').first
    paper_reviewer_task.reviewer_ids = [reviewer.id.to_s]
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in reviewer
  end

  scenario "Reviewer can write a reviewer report" do
    dashboard_page = DashboardPage.new
    manuscript_page = dashboard_page.view_submitted_paper paper
    manuscript_page.view_card 'Reviewer Report' do |overlay|
      overlay.mark_as_complete
      expect(overlay).to be_completed
    end
  end
end