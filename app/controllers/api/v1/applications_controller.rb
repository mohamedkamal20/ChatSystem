require 'securerandom'

module Api
  module V1

    class ApplicationsController < ApplicationController
      def index
        applications = Application.all
        render json:applications
      end

      def show
        application = Application.find_by_token(params[:id])
        render json:application
      end

      def create
        uuid = SecureRandom.uuid
        application = Application.new(application_params)
        application.token = uuid
        application.save
        render json:application
      end

      def update
        application = Application.find_by_token(params[:id])
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
