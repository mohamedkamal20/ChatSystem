module Api
  module V1
    class MessagesController < ApplicationController

      #/api/v1/applications/{token}/chats/{chat_id}/messages [GET]
      def index
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          chat_number = params[:chat_id]
          chat = application.chats.find_by_number(chat_number)
          if chat
            render json: chat.messages
          else
            render json: {"errors": "This chat number : #{chat_number} does not exist"}, :status => :bad_request
          end
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
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
          render json: {"errors": " application token or chat number does not exist"}, :status => :bad_request
        end
      end

      #/api/v1/applications/{token}/chats/{chat_id}/messages/{id} [GET]
      def show
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          chat_number = params[:chat_id]
          chat = application.chats.find_by_number(chat_number)
          if chat
            message_number = params[:id]
            message = chat.messages.find_by_number(message_number)
            if message
              render json: message
            else
              render json: {"errors": "This message number : #{message_number} does not exist"}, :status => :bad_request
            end
          else
            render json: {"errors": "This chat number : #{chat_number} does not exist"}, :status => :bad_request
          end
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
        end
      end

      #/api/v1/applications/{token}/chats/{chat_id}/messages/{id} [PATCH] {"message":{"message":"message"}}
      def update
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          chat_number = params[:chat_id]
          chat = application.chats.find_by_number(chat_number)
          if chat
            message_number = params[:id]
            message = chat.messages.find_by_number(message_number)
            if message
              begin
                if message.update_attributes(message_params)
                  render json:message
                else
                  render json: message.errors.messages, :status => :bad_request
                end
              rescue Exception => err
                render json: {"errors": "#{err}"}
              end
            else
              render json: {"errors": "This message number : #{message_number} does not exist"}, :status => :bad_request
            end
          else
            render json: {"errors": "This chat number : #{chat_number} does not exist"}, :status => :bad_request
          end
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
        end
      end

      private
      def message_params
         params.require(:message).permit(:message)
      end
    end
  end
end