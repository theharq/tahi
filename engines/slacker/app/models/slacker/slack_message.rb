require 'slack-notifier'

module Slacker
  class SlackMessage < ActiveRecord::Base

    include EventStreamNotifier

    belongs_to :slack_task

    after_create :post_to_slack


    private

    def post_to_slack
      notifier = Slack::Notifier.new("https://hooks.slack.com/services/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", channel: "#general", username: "slacker")
      notifier.ping(message)
    end

  end
end
