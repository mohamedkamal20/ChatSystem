require 'bunny'
require 'json'

connection = Bunny.new(automatically_recover: true )
connection.start

channel = connection.create_channel
queue = channel.queue('chats_development')

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  # block: true is only used to keep the main thread
  # alive. Please avoid using it in real world applications.
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts body
    # rabbit_message = JSON.parse(body)
    # application = Application.find_application(rabbit_message["token"])
    # if application
    #   chat = Chat.new
    #   chat.chat_name = rabbit_message["chat_name"]
    #   chat.created_at = rabbit_message["created_at"]
    #   chat.updated_at = rabbit_message["updated_at"]
    #   chat.number = rabbit_message["number"]
    #   application.chats << chat
    #   chat.save
    #   end
end
rescue Interrupt => _
  connection.close
  exit(0)
end
