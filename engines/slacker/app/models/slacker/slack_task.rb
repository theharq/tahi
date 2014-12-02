module Slacker
  class SlackTask < Task
    # uncomment the following line if you want to enable event streaming for this model
    include EventStreamNotifier

    register_task default_title: "Slack Task", default_role: "author"

    has_many :slack_messages

    def active_model_serializer
      SlackTaskSerializer
    end
  end
end
