require 'bunny'
require 'json'


def consume_chat_from_queue
  connection = Bunny.new(:host => ENV.fetch("RABBITMQ_HOST"),
                         :port => "5672",
                         :vhost => "/",
                         :user => ENV.fetch("RABBITMQ_USER"),
                         :pass => ENV.fetch("RABBITMQ_PASSWORD"),
                         automatically_recover: true )
  connection.start

  channel = connection.create_channel
  queue = channel.queue('chats_development')

  begin
    queue.subscribe do |_delivery_info, _properties, body|
      rabbit_message = JSON.parse(body)
      application = Application.find(rabbit_message["application_id"])
      puts application
      if application
        chat = Chat.new
        chat.chat_name = rabbit_message["chat_name"]
        chat.created_at = rabbit_message["created_at"]
        chat.updated_at = rabbit_message["updated_at"]
        chat.number = rabbit_message["number"]
        application.chats << chat
        chat.save
      end
    end
  rescue Interrupt => _
    connection.close
    exit(0)
  end
end

def consume_message_from_queue
  connection = Bunny.new(:host => ENV.fetch("RABBITMQ_HOST"),
                         :port => ENV.fetch("RABBITMQ_PORT"),
                         :vhost => "/",
                         :user => ENV.fetch("RABBITMQ_USER"),
                         :pass => ENV.fetch("RABBITMQ_PASSWORD"),
                         automatically_recover: true )
  connection.start

  channel = connection.create_channel
  queue = channel.queue('messages_development')

  begin
    queue.subscribe do |_delivery_info, _properties, body|
      rabbit_message = JSON.parse(body)
      chat = Chat.find(rabbit_message["chat_id"])
      if chat
        message = Message.new
        message.created_at = rabbit_message["created_at"]
        message.updated_at = rabbit_message["updated_at"]
        message.number = rabbit_message["number"]
        message.message = rabbit_message["message"]
        chat.messages << message
        message.save
      end
    end
  rescue Interrupt => _
    connection.close

    exit(0)
  end
end

Thread.new{consume_chat_from_queue}
Thread.abort_on_exception=true
Thread.new{consume_message_from_queue}
Thread.abort_on_exception=true