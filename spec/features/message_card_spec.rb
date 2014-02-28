require 'spec_helper'

feature 'Message Cards', js: true do
  let(:admin) do
    User.create! username: 'zoey',
      first_name: 'Zoey',
      last_name: 'Bob',
      email: 'hi@example.com',
      password: 'password',
      password_confirmation: 'password',
      affiliation: 'PLOS',
      admin: true
  end

  let!(:albert) do
    User.create! username: 'albert',
      first_name: 'Albert',
      last_name: 'Einstein',
      email: 'einstein@example.org',
      password: 'password',
      password_confirmation: 'password',
      affiliation: 'Universität Zürich',
      journal_roles: [JournalRole.new(journal: journal, admin: true)]
  end

  before do
    sign_in_page = SignInPage.visit
    sign_in_page.sign_in admin.email
  end

  let(:journal) { Journal.create! }

  let(:paper) do
    Paper.create! short_title: 'foobar',
      title: 'Foo bar',
      submitted: true,
      journal: journal,
      user: admin
  end

  let(:subject_text) { 'Verify Author Signatures' }
  let(:body_text) { 'Please remember to verify signatures of every paper author.' }
  let(:participants) { [albert] }
  scenario "Admin can add a new message" do
    task_manager_page = TaskManagerPage.visit paper

    needs_editor_phase = task_manager_page.phase 'Assign Editor'
    needs_editor_phase.new_message_card subject: subject_text,
      body: body_text,
      participants: participants

    needs_editor_phase.view_card subject_text, cardObject: MessageCardOverlay do |card|
      expect(card.subject).to == subject_text
      expect(card.body).to == body_text
      expect(card.participants).to match_array(participants.map(&:full_name))

    end
  end

end
