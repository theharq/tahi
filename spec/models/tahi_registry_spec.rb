require 'spec_helper'

describe TahiRegistry do

  class SampleSubscriber
  end

  before(:all) do
    TahiRegistry.subscribe("some:message", SampleSubscriber, :callme_maybe)
  end

  it "maintains subscriptions" do
    expect(TahiRegistry.subscribers["some:message"].count).to eq(1)
  end

  it "delivers notifications" do
    data = { moar: :data }
    expect(SampleSubscriber).to receive(:callme_maybe).with(data).once
    TahiRegistry.deliver("some:message", data)
  end

end
