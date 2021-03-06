require 'rails_helper'

describe StandardTasks::RegisterDecisionTask do
  context "letters" do
    let(:paper) do
      FactoryGirl.create :paper, :with_tasks, title: "Crazy stubbing tests on rats"
    end

    let(:task) { StandardTasks::RegisterDecisionTask.create!(title: "Register Decision", role: "editor", phase: paper.phases.first) }

    before do
      user = double(:last_name, last_name: 'Mazur')
      editor = double(:full_name, full_name: 'Andi Plantenberg')
      journal = double(:name, name: 'PLOS Yeti')
      allow(paper).to receive(:creator).and_return(user)
      allow(paper).to receive(:editors).and_return([editor])
      allow(paper).to receive(:journal).and_return(journal)
      allow(task).to receive(:paper).and_return(paper)
    end

    describe "#accept_letter" do
      it "returns the letter with the author's name filled in" do
        expect(task.accept_letter).to match(/Mazur/)
      end

      it "returns the letter with the editor's name filled in" do
        expect(task.accept_letter).to match(/Andi Plantenberg/)
      end

      it "returns the letter with journal name filled in" do
        expect(task.accept_letter).to match(/PLOS Yeti/)
      end

      it "returns the letter with paper title filled in" do
        expect(task.accept_letter).to match(/Crazy stubbing tests on rats/)
      end
    end

    describe "#revise_letter" do
      it "returns the letter with the author's name filled in" do
        expect(task.revise_letter).to match(/Mazur/)
      end

      it "returns the letter with the editor's name filled in" do
        expect(task.revise_letter).to match(/Andi Plantenberg/)
      end

      it "returns the letter with journal name filled in" do
        expect(task.revise_letter).to match(/PLOS Yeti/)
      end

      it "returns the letter with paper title filled in" do
        expect(task.revise_letter).to match(/Crazy stubbing tests on rats/)
      end
    end

    describe "#reject_letter" do
      it "returns the letter with the author's name filled in" do
        expect(task.reject_letter).to match(/Mazur/)
      end

      it "returns the letter with the editor's name filled in" do
        expect(task.reject_letter).to match(/Andi Plantenberg/)
      end

      it "returns the letter with journal name filled in" do
        expect(task.reject_letter).to match(/PLOS Yeti/)
      end

      it "returns the letter with paper title filled in" do
        expect(task.reject_letter).to match(/Crazy stubbing tests on rats/)
      end
    end

    context "when the editor hasn't been assigned yet" do
      it "returns 'Editor not assigned'" do
        allow(paper).to receive(:editors).and_return([])
        expect(task.accept_letter).to match(/Editor not assigned/)
        expect(task.accept_letter).to_not match(/Andi Plantenberg/)
      end
    end
  end

  describe "save and retrieve paper decision and decision letter" do
    let(:paper) {
      FactoryGirl.create(:paper, :with_tasks,
        title: "Crazy stubbing tests on rats",
        decision: "Accepted",
        decision_letter: "Lorem Ipsum")
    }

    let(:task) {
      StandardTasks::RegisterDecisionTask.create(
        title: "Register Decision",
        role: "editor",
        phase: paper.phases.first)
    }

    before do
      allow(task).to receive(:paper).and_return(paper)
    end

    describe "#paper_decision" do
      it "returns paper's decision" do
        expect(task.paper_decision).to eq("Accepted")
      end
    end

    describe "#paper_decision=" do
      it "returns paper's decision" do
        task.paper_decision = "Rejected"
        expect(task.paper_decision).to eq("Rejected")
      end
    end

    describe "#paper_decision_letter" do
      it "returns paper's decision" do
        expect(task.paper_decision_letter).to eq("Lorem Ipsum")
      end
    end

    describe "#paper_decision_letter=" do
      it "returns paper's decision" do
        task.paper_decision_letter = "Rejecting because I can"
        expect(task.paper_decision_letter).to eq("Rejecting because I can")
      end
    end

    describe "#send_emails" do
      context "if the task transitions to completed" do
        it "sends emails to the paper's author" do
          allow(StandardTasks::RegisterDecisionMailer).to receive_message_chain("delay.notify_author_email") { true }
          task.completed = true
          task.save!
          expect(task.send_emails).to eq true
        end
      end

      context "if the task is updated but not completed" do
        it "does not send emails" do
          StandardTasks::ReviewerReportMailer = double(:reviewer_report_mailer)
          task.completed = false # or any other update
          task.save!
          expect(task.send_emails).to eq nil
        end
      end
    end
  end
end
