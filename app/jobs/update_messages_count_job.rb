class UpdateMessagesCountJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chats = Chat.all
    chats.each { |chat|
      chat.messages_count = chat.messages.count
      chat.save
    }
  end

  UpdateMessagesCountJob.set(wait: 30.minute).perform_later(nil)
end
