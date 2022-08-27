class UpdateMessagesCountJob < ApplicationJob
  queue_as :default

  def perform(*args)
    chats = Chat.all
    chats.each { |chat|
      chat.messages_count = chat.messages.count
      chat.save
    }
  end
end

# Sidekiq::Cron::Job.create(name: 'update messages count - every 1min', cron: '*/1 * * * *', class: 'UpdateMessagesCountJob')
