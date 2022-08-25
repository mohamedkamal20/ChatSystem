module Api
  module V1
    class ChatsController < ApplicationController

      #/api/v1/applications/{token}/chats [GET]
      def index
        application = Application.find_application(params[:application_id])
        if application
          render json: application.chats
        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      #/api/v1/applications/{token}/chats/{id} [GET]
      def show
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:id])
          if chat
            render json: chat
          else
            render json:{:message => "chat not found"}, :status => 404
          end

        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      # This endpoint is deprecated just for testing purposes (Golang endpoint)
      #/api/v1/applications/{token}/chats [POST] {"chat_name":"chat_name"}
      def create
        application = Application.find_application(params[:application_id])
        if application
          chat = Chat.new(chat_params)
          chat.number = application.chats.count + 1
          application.chats << chat
          chat.save
          render json:chat
        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      #/api/v1/applications/{token}/chats [PATCH] {"chat_name":"chat_name"}
      def update
        application = Application.find_application(params[:application_id])
        if application
          chat = application.chats.find_chat(params[:id])
          chat.update_attributes(chat_params)
          render json:chat
        else
          render json:{:message => "application not found"}, :status => 404
        end
      end

      private
      def chat_params
        params.require(:chat).permit(:chat_name)
      end
    end
  end
end
