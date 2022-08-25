module Api
  module V1
    class MessagesController < ApplicationController

      #/api/v1/applications/{token}/chats/{chat_id}/messages [GET]
      def index
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:chat_id])
          if chat
            render json: chat.messages
          else
            render json:{:message => "chat not found"}, :status => 404
          end

        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      #/api/v1/applications/{token}/chats/{chat_id}/messages/search [GET] {"message":"message"}
      def search
        token = params[:application_id]
        chat_number = params[:chat_id]
        message = params[:message] == {} ? "" : params[:message]
        if token and chat_number
          result = Message.search(where:{token:token, chat_number:chat_number, message:{like: "%#{message}%"}})
          render json: result
        else
          render json:{:message => "application token or chat number not valid"}, :status => 404
        end
      end

      #/api/v1/applications/{token}/chats/{chat_id}/messages/{id} [GET]
      def show
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:chat_id])
          if chat
            message = chat.messages.find_message(params[:id])
            if message
              render json: message
            else
              render json:{:message => "message not found"}, :status => 404
            end
          else
            render json:{:message => "chat not found"}, :status => 404
          end

        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      # This endpoint is deprecated just for testing purposes (Golang endpoint)
      #/api/v1/applications/{token}/chats/{chat_id}/messages [POST] {message":{"message":"message"}}
      def create
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:chat_id])
          if chat
            message = Message.new(message_params)
            message.number = chat.messages.count + 1
            chat.messages << message
            message.save
            render json: message
          else
            render json:{:message => "chat not found"}, :status => 404
          end
        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      #/api/v1/applications/{token}/chats/{chat_id}/messages/{id} [PATCH] {"message":{"message":"message"}}
      def update
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:chat_id])
          if chat
            message = chat.messages.find_message(params[:id])
            message.update_attributes(message_params)
            render json:message
          else
            render json:{:message => "chat not found"}, :status => 404
          end
        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      private
      def message_params
        params.require(:message).permit(:message)
      end
    end
  end
end