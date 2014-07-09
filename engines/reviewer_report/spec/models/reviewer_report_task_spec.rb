require 'spec_helper'

describe ReviewerReport::Task do
  let(:task) { ReviewerReport::Task.new }

  describe "defaults" do
    specify { expect(task.title).to eq 'Reviewer Report' }
    specify { expect(task.role).to eq 'reviewer' }
  end

  describe "subscriptions" do
    it "listens for add_reviewers" do
      subscriptions = TahiRegistry.subscribers_of_message("paper:add_reviewers").map(&:to_s)
      expect(subscriptions).to include("ReviewerReport::Task.add_reviewers")
    end

    it "listens for remove_reviewers" do
      subscriptions = TahiRegistry.subscribers_of_message("paper:remove_reviewers").map(&:to_s)
      expect(subscriptions).to include("ReviewerReport::Task.remove_reviewers")
    end
  end

  describe ".add_reviewers" do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    let(:paper) { FactoryGirl.build_stubbed(:paper) }
    let(:phase) { FactoryGirl.build_stubbed(:phase) }
    let(:director) { PaperDirector.new(paper) }

    before do
      allow(ReviewerReport::Task).to receive(:default_phase).and_return(phase)
    end

    it "adds reviewers" do
      ReviewerReport::Task.add_reviewers(user_ids: [user.id], director: director)
      expect(ReviewerReport::Task.where(phase: phase, assignee: user).exists?).to eq(true)
    end

  end

  describe ".remove_reviewers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:paper) { FactoryGirl.create(:paper, phases: [phase]) }
    let(:phase) { FactoryGirl.create(:phase) }
    let(:director) { PaperDirector.new(paper) }

    let(:task) { FactoryGirl.create(:task, type: "ReviewerReport::Task", phase: phase, assignee: user) }

    before do
      task
    end

    it "adds reviewers" do
      expect(ReviewerReport::Task.where(id: task.id).exists?).to be(true)
      ReviewerReport::Task.remove_reviewers(user_ids: [user.id], director: director)
      expect(ReviewerReport::Task.where(id: task.id).exists?).to be(false)
    end

  end






  describe "#destroy" do
    let(:paper) { FactoryGirl.create :paper, :with_tasks }
    subject(:task) { FactoryGirl.create :reviewer_report_task, phase: paper.phases.first }

    before { PaperRole.create!(reviewer: true, user: task.assignee, paper: paper) }

    it "destroys the reviewer's paper role" do
      expect{ task.destroy }.to change{ PaperRole.count }.by(-1)
    end
  end
end
