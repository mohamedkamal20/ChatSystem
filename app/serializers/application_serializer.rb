class ApplicationSerializer < ActiveModel::Serializer
  attributes :token, :application_name, :chats_count
end