class SlackSendJob < ApplicationJob
  queue_as :slack

  def perform(text, channel=nil)

    SlackService.alert(text, channel)

    # Do something later
  end
end
