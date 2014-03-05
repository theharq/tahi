require 'spec_helper'

describe MessageTaskCreator do

  describe "#with_initial_comment" do
    context "an existing paper and a user" do
      let(:user) { FactoryGirl.create :user }
      let(:paper) { FactoryGirl.create :paper }
      let(:phase) { paper.phases.first }

      let(:msg_subject) { "A subject." }
      let(:ids) { [user.id] }
      let(:msg_body) { "It's a test body." }
      let(:msg_params) { {message_subject: msg_subject, participant_ids: ids, message_body: msg_body} }
      let(:result) do
        MessageTaskCreator.with_initial_comment(phase, msg_params,
                                                       user)
      end

      context "with a message subject and body" do

        it "returns a new MessageTask with a subject and participants" do
          expect(result.message_subject).to eq(msg_subject)
          expect(result.participants.map(&:id)).to match_array(ids)
        end

        it "creates a new Comment for the MessageTask" do
          expect(result.comments.count).to eq 1
          c = result.comments.first
          expect(c.body).to eq(msg_body)
          expect(c.commenter).to eq(user)
        end
      end

      context "with no message body" do
        let(:msg_body) { nil }
        it "creates the MessageTask, but no comment" do
          expect(result.message_subject).to eq(msg_subject)
          expect(result.comments.count).to eq(0)
        end
      end

      context "with no subject" do
        let(:msg_subject) { nil }
        it "raises a validation error" do
          expect {result}.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
      context "with no participants" do
        let(:ids) { [] }
        it "raises a validation error" do
          expect {result}.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end