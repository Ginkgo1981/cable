class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    pp "[MessageBroadcastJob] perform message: #{message}"
    ActionCable.server.broadcast "student:#{message.student.id}", message: {msg: message.content}
  end
end
