# require 'bunny'
# require 'json'
#
#
# def consume_chat_message
#   connection = Bunny.new(automatically_recover: true )
#   connection.start
#
#   channel = connection.create_channel
#   queue = channel.queue('chats_development')
#
#   begin
#     queue.subscribe do |_delivery_info, _properties, body|
#       rabbit_message = JSON.parse(body)
#       application = Application.find_by_token(rabbit_message["token"])
#       puts application
#       if application
#         chat = Chat.new
#         chat.chat_name = rabbit_message["chat_name"]
#         chat.created_at = rabbit_message["created_at"]
#         chat.updated_at = rabbit_message["updated_at"]
#         chat.number = rabbit_message["number"]
#         application.chats << chat
#         chat.save
#       end
#     end
#   rescue Interrupt => _
#     connection.close
#     exit(0)
#   end
# end
