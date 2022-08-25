if defined?(Rails::Server)
  Rails.application.config.after_initialize do
    UpdateChatsCountJob.perform_later nil
    UpdateMessagesCountJob.perform_later nil
  end
end