class AvailabilitiesController < ApplicationController
  def index
    render json: Availability.all
  end

  def new
  end

  def edit
  end

  def show
    render json: Availability.where(available_day:params[:date])
    # Availability.where(available_day:'2017-12-19')
  end

  def update
  end
end
