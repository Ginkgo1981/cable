class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)

    pp "======= perform ========"
    ActionCable.server.broadcast "user:#{message.user.id}", message: {msg: message.content}
  end
end
