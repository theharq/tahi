require 'spec_helper'

feature 'Message Cards', js: true do
  let(:admin) { create :user, admin: true, first_name: "Admin" }
  let(:journal) { create(:journal) }
  let(:albert) { create :user, first_name: "Albert" }

  before do
    assign_journal_role(journal, albert, :admin)
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in admin
  end


  let(:paper) do
    FactoryGirl.create(:paper, :with_tasks, user: admin, submitted: true, journal: journal)
  end

  def create_comment_with_comment_looks(task, comment_params)
    task.comments.create_with_comment_look(task, comment_params)
  end

  describe "creating a new message" do
    let(:subject_text) { 'A sample message' }
    let(:body_text) { 'Everyone add some comments to this test post.' }
    let(:participants) { [albert] }
    scenario "Admin can add a new message" do
      task_manager_page = TaskManagerPage.visit paper

      needs_editor_phase = task_manager_page.phase 'Assign Editor'
      needs_editor_phase.new_card overlay: NewMessageCardOverlay,
        subject: subject_text,
        body: body_text,
        participants: participants,
        creator: admin

      needs_editor_phase = task_manager_page.phase 'Assign Editor'
      needs_editor_phase.view_card subject_text, MessageCardOverlay do |card|
        expect(card.subject).to eq subject_text
        expect(card.comments.first).to have_text body_text
        expect(card.participants).to match_array [albert.full_name, admin.full_name]
      end
    end
  end

  describe "commenting on an existing message" do
    let(:phase) { paper.phases.first }
    let!(:message) do
      create :message_task, phase: phase, participants: participants
    end
    let!(:initial_comment) { create :comment, commenter: commenter, task: message }

    context "blank comments" do
      let(:commenter) { admin }
      let(:participants) { [admin] }
      scenario "user can't add any" do
        task_manager_page = TaskManagerPage.visit paper
        task_manager_page.view_card message.title, MessageCardOverlay do |card|
          card.post_message 'Hello'
          card.post_message ''
          expect(card.comments.length).to eq 2
        end
      end
    end

    context "the user is already a participant" do
      let(:commenter) { admin }
      let(:participants) { [admin] }

      scenario "the user can add a commment" do
        task_manager_page = TaskManagerPage.visit paper
        task_manager_page.view_card message.title, MessageCardOverlay do |card|
          expect(card).to have_css('.message-overlay')
          card.post_message 'Hello'
          expect(card.participants).to match_array(participants.map(&:full_name))
          expect(card.comments.last.find('.comment-name')).to have_text(admin.full_name)
        end
      end

      scenario "the user can add any other user as a participant" do
        task_manager_page = TaskManagerPage.visit paper
        task_manager_page.view_card message.title, MessageCardOverlay do |card|
          expect(card).to have_css('.message-overlay')
          card.add_participants albert
          expect(card).to have_participants(albert)
        end
        task_manager_page = TaskManagerPage.visit paper
        task_manager_page.view_card message.title, MessageCardOverlay do |card|
          expect(card).to have_participants(albert)
        end
      end
    end

    context "the user isn't a participant" do
      let(:commenter) { albert }
      let(:participants) { [albert] }
      scenario "the user becomes a participant after commenting" do
        task_manager_page = TaskManagerPage.visit paper
        task_manager_page.view_card message.title, MessageCardOverlay do |card|
          expect(card).to have_css('.message-overlay')
          card.post_message 'Hello'
          expect(card).to have_participants(admin, albert)
          expect(card.comments.last.find('.comment-name')).to have_text(admin.full_name)
        end
      end
    end
  end

  describe "unread comments" do
    let(:commenter) { albert }
    let(:participants) { [admin, albert] }
    let(:phase) { paper.phases.first }
    let!(:initial_comments) do
      comment_count.times.map { create_comment_with_comment_looks(message, commenter: commenter, body: "FOO") }
    end
    let(:message) { create :message_task, phase: phase, participants: participants }
    let(:comment_count) { 4 }
    let(:task_manager_page) { TaskManagerPage.visit paper }

    scenario "displays the number of unread comments as badge on message card" do
      expect(task_manager_page.message_tasks.first.unread_comments_badge).to eq comment_count
    end
  end
end
