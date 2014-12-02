module Slacker
  class SlackMessagesPolicy < ::ApplicationPolicy

    primary_resource :slack_message

    def connected_users
      User.all
    end

    def show?
      true
    end

  end
end
