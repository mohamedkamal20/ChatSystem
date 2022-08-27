class UpdateChatsCountJob < ApplicationJob
  queue_as :default

  def perform(*args)
    applications = Application.all
    applications.each { |application|
      application.chats_count = application.chats.count
      application.save
    }
  end
end
Sidekiq::Cron::Job.create(name: 'update chats count - every 1min', cron: '*/1 * * * *', class: 'UpdateChatsCountJob')
