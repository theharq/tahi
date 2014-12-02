module Slacker
  class SlackMessageSerializer < ActiveModel::Serializer

    root :slack_message
    attributes :id, :username, :message

    has_one :slack_task, polymorphic: true

  end
end
