module Api
  module V1
    class MessagesController < ApplicationController

      def index
        application = Application.find_by_token(params[:application_id])
        if application
          chat = application.chats.find_by_number(params[:chat_id])
          if chat
            render json: chat.messages
          else
            render json:{:message => "chat not found"}, :status => 404
          end

        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      def show
        application = Application.find_by_token(params[:application_id])
        if application
          chat = application.chats.find_by_number(params[:chat_id])
          if chat
            message = chat.messages.find_by_number(params[:id])
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

      def create
        application = Application.find_by_token(params[:application_id])
        if application
          chat = application.chats.find_by_number(params[:chat_id])
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

      def update
        application = Application.find_by_token(params[:application_id])
        if application
          chat = application.chats.find_by_number(params[:chat_id])
          if chat
            message = chat.messages.find_by_number(params[:id])
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