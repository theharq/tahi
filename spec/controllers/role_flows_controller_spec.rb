require 'spec_helper'
describe RoleFlowsController do

  expect_policy_enforcement
  authorize_policy(RoleFlowsPolicy, true)

  let(:journal) { FactoryGirl.create(:journal) }
  let(:role) { FactoryGirl.create(:role, journal: journal) }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "#update" do
    subject(:do_request) do
      put :update, {
        format: 'json',
        id: flow.id,
        role_flow: {
          title: new_title
        }
      }
    end

    let!(:flow) { FactoryGirl.create(:role_flow, role: role, title: "My tasks") }
    let(:new_title) { "Up for grabs" }

    it "updates the corresponding empty text when title changes" do
      do_request
      expect(flow.reload.empty_text).to eq(FlowTemplate.template(new_title)[:empty_text])
    end

    context "title does not map to a template" do
      let(:new_title) { "Something that does not match" }

      it "returns head 422" do
        do_request
        expect(response.status).to eq(422)
      end
    end
  end
end