module Slacker
  class SlackMessagesController < ActionController::Base

    respond_to(:json)

    def create
      task = Task.find(params[:slack_message][:slack_task_id])
      slack_message = task.slack_messages.create(slack_message_params)
      respond_with(slack_message)
    end

    def show
    end


    private

    def slack_message_params
      params.require(:slack_message).permit(:username, :message)
    end

  end
end
