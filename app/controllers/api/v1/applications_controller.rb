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
        application = Application.find_application(params[:id])
        render json:application
      end

       #/api/v1/applications/ [POST] {"application_name" : "application_name"}
      def create
        uuid = SecureRandom.uuid
        application = Application.new(application_params)
        application.token = uuid
        application.save
        render json:application
      end

      #/api/v1/applications/{id} [PATCH] {"application_name" : "application_name"}
      def update
        application = Application.find_application(params[:id])
        application.update_attributes(application_params)
        render json:application
      end

      private
      def application_params
        params.require(:application).permit(:application_name)
      end
    end
  end
end
