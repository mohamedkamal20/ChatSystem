class ApplicationsController < ApplicationController
  def index
    applications = Application.all
    render json:applications
  end

  def show
    application = Application.find(params[:id])
    render json:application
  end

  def create
    application = Application.create(application_params)
    render json:application
  end

  def update
    application = Application.find(params[:id])
    application.update_attributes(application_params)
    render json:application
  end

  private
  def application_params
    params.require(:application).permit(:application_name)
  end
end
