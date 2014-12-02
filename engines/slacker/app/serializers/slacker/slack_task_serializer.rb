module Slacker
  class SlackTaskSerializer < ::TaskSerializer

    has_many :slack_messages, embed: :ids, include: true, serializer: SlackMessageSerializer

  end
end
