require 'bunny'
require 'json'

connection = Bunny.new(automatically_recover: true )
connection.start

channel = connection.create_channel
queue = channel.queue('messages_development')

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  # block: true is only used to keep the main thread
  # alive. Please avoid using it in real world applications.
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts body
    # rabbit_message = JSON.parse(body)
    # chat = Chat.find_chat(rabbit_message["chat_number"])
    # if chat
    #     message = Message.new
    #     message.created_at = rabbit_message["created_at"]
    #     message.updated_at = rabbit_message["updated_at"]
    #     message.number = rabbit_message["number"]
    #     message.message = rabbit_message["message"]
    #     chat.messages << rabbit_message
    #     message.save
    # end
 end
rescue Interrupt => _
  connection.close

  exit(0)
  end