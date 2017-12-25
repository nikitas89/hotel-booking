class AvailabilitiesController < ApplicationController
  # before_action :authenticate_user
  # to activate in production
  # before_action :authenticate_admin!
  require 'date'
  def index
    render json: Availability.all
  end

  # def new
  # end
  #
  # def edit
  # end

  #e.g. /availabilities/2017-12-23
  def show
    render json: Availability.where(available_day:params[:date])
    # Availability.where(available_day:'2017-12-19')
  end

  #e.g. /availabilities/range/2017-12-26&2017-12-28
  def show_range
    dates =  params[:dates]
    num = dates.index('&')
    start_date = dates[0...num]
    end_date = dates[num+1..dates.length-1]
    start_date = Date.strptime(start_date, '%Y-%m-%d')
    end_date = Date.strptime(end_date, '%Y-%m-%d')
    @availabilities = []

    (start_date..end_date).each {|day|
      available = []
      available = Availability.where(available_day:day)
      @availabilities << available
    }
    render json: @availabilities
  end

  def update
  end
end
