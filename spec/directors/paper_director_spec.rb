require "spec_helper"

describe PaperDirector do
  let(:paper) { FactoryGirl.create(:paper) }
  let(:user) { FactoryGirl.create(:user) }
  let(:director) { PaperDirector.new(paper) }

  it "adds reviewers" do
    expect(TahiRegistry).to receive(:deliver).with("paper:add_reviewers", hash_including(director: director))
    director.add_reviewers([user.id])
    expect(paper.reviewers).to include(user)
  end

  describe "#remove_reviewers" do
    before do
      PaperRole.reviewers_for(paper).where(user_id: user.id).create!
    end

    it "removes reviewers" do
      expect(TahiRegistry).to receive(:deliver).with("paper:remove_reviewers", hash_including(director: director))
      director.remove_reviewers([user.id])
      expect(paper.reviewers).to_not include(user)
    end
  end
end
