class ChatSerializer < ActiveModel::Serializer
  attributes :number, :chat_name, :messages_count
end
