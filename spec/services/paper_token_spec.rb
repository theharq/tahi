require 'spec_helper'

describe PaperToken do

  let(:paper) { FactoryGirl.create(:paper) }

  describe "#generate" do
    context "when the paper_id is provided" do
      it "generates a token valid for 1 month" do
        # paper_token = PaperToken.new(paper_id: paper.id)
        paper_token = PaperToken.new(paper_id: paper.id).generate
        expect(paper_token.class).to eq String
        expect(paper_token).to_not be_empty
        expect(paper_token.length).to be > 0
        # assert specific length?
        # TODO assert bad if more than a month
      end
    end

    context "when the paper_id is not provided" do
      it "raises error" do
        expect { PaperToken.new }.to raise_error ArgumentError
      end
    end

    context "when the provided paper_id is invalid" do
      it "raises error" do
        expect { PaperToken.new(paper_id: 2).generate }
          .to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#valid?" do
    context "when the token is still valid" do
      it "returns true" do
        token = PaperToken.new(paper_id: paper.id).generate
        PaperToken.valid?(token)
      end
    end

    context "when the token is older than 1 month" do
      it "returns false" do
        old_token = PaperToken.verifier.generate([paper.id, Time.now - 2.month])

        expect(PaperToken.valid?(old_token)).to eq false
      end
    end

    context "when the token is provided for a missing paper" do
      it "raises error" do
        expect {
          PaperToken.new(paper_id: 2)
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when the paper_id is invalid" do
      it "raises error" do
        invalid_paper_id = "1234"
        token = PaperToken.verifier.generate([invalid_paper_id, 1.month.from_now])
        expect(PaperToken.valid?(token)).to eq false
      end
    end

    context "when the rails secret token has changed" do
      it "raises InvalidTokenProvided" do
        new_verifier = Rails.application.message_verifier("haha")
        token = new_verifier.generate([paper.id, 1.month.from_now])

        expect {
          PaperToken.deserialize(token)
        }.to raise_error ActiveSupport::MessageVerifier::InvalidSignature
      end
    end

  end
end
