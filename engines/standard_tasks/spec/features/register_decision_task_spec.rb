require 'spec_helper'

feature "Register Decision", js: true do

  let(:journal) { FactoryGirl.create :journal }

  let!(:editor) { create :user }

  let!(:paper) do
    FactoryGirl.create(:paper, :with_tasks, user: editor, submitted: true, journal: journal)
  end

  before do
    assign_journal_role(journal, editor, :editor)
    paper_role = create(:paper_role, :editor, user: editor, paper: paper)
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in editor
  end

  scenario "Editor registers a decision on the paper" do
    dashboard_page = DashboardPage.new
    manuscript_page = dashboard_page.view_submitted_paper paper
    manuscript_page.view_card 'Register Decision' do |overlay|
      overlay.register_decision = "Accepted"
      overlay.decision_letter = "Accepting this because I can"
      overlay.mark_as_complete
      expect(overlay).to be_completed
    end
  end
end