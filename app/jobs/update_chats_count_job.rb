class UpdateChatsCountJob < ApplicationJob
  queue_as :default

  def perform(*args)
    applications = Application.all
    applications.each { |application|
      application.chats_count = application.chats.count
      application.save
    }

    UpdateChatsCountJob.set(wait: 30.minute).perform_later(nil)
  end
end
