require 'securerandom'

module Api
  module V1

    class ApplicationsController < ApplicationController

      #/api/v1/applications/ [GET]
      def index
        applications = Application.all
        render json:applications
      end
      #/api/v1/applications/{id} [GET]
      def show
        application_token  = params[:id]
        application = Application.find_by_token(application_token)
        if application
          render json: application
        else
          render json: {"errors": "This token : #{application_token} does not exist"}
        end
      end

       #/api/v1/applications/ [POST] {"application_name" : "application_name"}
      def create
        begin
          uuid = SecureRandom.uuid
          application = Application.new(application_params)
          application.token = uuid
          if application.save
            render json:application
          else
            render json: application.errors.messages, status: :bad_request
          end
        rescue Exception => err
          render json: {"errors": "#{err}"}, :status => :bad_request
        end
      end

      #/api/v1/applications/{id} [PATCH] {"application_name" : "application_name"}
      def update
        begin
          application_token = params[:id]
          application = Application.find_by_token(application_token)
          if application.update_attributes(application_params)
            render json:application
          else
            render json: application.errors.messages, status: :bad_request
          end
        rescue Exception => err
          render json: {"errors": "#{err}"}, :status => :bad_request
        end
      end

      private
      def application_params
        params.require(:application).permit(:application_name)
      end
    end
  end
end
