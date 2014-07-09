require 'spec_helper'

describe PaperReviewer::Task do

  subject(:task) { PaperReviewer::Task.new }

  describe "defaults" do
    specify { expect(task.title).to eq 'Assign Reviewers' }
    specify { expect(task.role).to eq 'editor' }
  end

  describe "#reviewer_ids=" do
    context "with no existing paper reviewers" do
      let(:reviewer_ids) { [1,2,3] }

      before do
        allow(task).to receive(:reviewer_ids).and_return([])
      end

      it "adds new reviewer ids" do
        expect_any_instance_of(PaperDirector).to receive(:add_reviewers).with(reviewer_ids)
        expect_any_instance_of(PaperDirector).to_not receive(:remove_reviewers)
        task.reviewer_ids = reviewer_ids
      end
    end

    context "with existing paper reviewers" do
      let(:reviewer_ids) { [1,2,3] }

      before do
        allow(task).to receive(:reviewer_ids).and_return(reviewer_ids)
      end

      it "adds and removes necessary reviewers" do
        expect_any_instance_of(PaperDirector).to receive(:remove_reviewers).with([2,3])
        expect_any_instance_of(PaperDirector).to receive(:add_reviewers).with([4])
        task.reviewer_ids = [1,4]
      end
    end
  end

end
