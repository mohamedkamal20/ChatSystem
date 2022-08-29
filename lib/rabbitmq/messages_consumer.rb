# require 'bunny'
# require 'json'
#
#
# def consume_message_message
#   connection = Bunny.new(automatically_recover: true )
#   connection.start
#
#   channel = connection.create_channel
#   queue = channel.queue('messages_development')
#
#   begin
#     queue.subscribe do |_delivery_info, _properties, body|
#       rabbit_message = JSON.parse(body)
#       application = Application.find_by_token(rabbit_message["token"])
#       if application
#         chat = application.chats.find(rabbit_message["chat_id"])
#         if chat
#           message = Message.new
#           message.created_at = rabbit_message["created_at"]
#           message.updated_at = rabbit_message["updated_at"]
#           message.number = rabbit_message["number"]
#           message.message = rabbit_message["message"]
#           chat.messages << rabbit_message
#           message.save
#         end
#       end
#     end
#   rescue Interrupt => _
#     connection.close
#
#     exit(0)
#   end
# end
