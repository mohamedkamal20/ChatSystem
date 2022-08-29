module Api
  module V1
    class ChatsController < ApplicationController

      #/api/v1/applications/{token}/chats [GET]
      def index
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          render json: application.chats
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
        end
      end

      #/api/v1/applications/{token}/chats/{id} [GET]
      def show
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          chat_number = params[:id]
          chat = application.chats.find_by_number(chat_number)
          if chat
            render json: chat
          else
            render json: {"errors": "Chat not found"}
          end
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
        end
      end

      #/api/v1/applications/{token}/chats [PATCH] {"chat_name":"chat_name"}
      def update
        application_token = params[:application_id]
        application = Application.find_by_token(application_token)
        if application
          chat_number = params[:id]
          chat = application.chats.find_by_number(chat_number)
          if chat
            begin
              if chat.update_attributes(chat_params)
                render json:chat
              else
                render json: chat.errors.messages, :status => :bad_request
              end
            rescue Exception => err
              render json: {"errors": "#{err}"}, :status => :bad_request
            end
          else
            render json: {"errors": "This chat number : #{chat_number} does not exist"}, :status => :bad_request
          end
        else
          render json: {"errors": "This token : #{application_token} does not exist"}, :status => :bad_request
        end
      end

      private
      def chat_params
        params.require(:chat).permit(:chat_name)
      end
    end
  end
end
