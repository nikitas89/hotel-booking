class BookingsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy ]
  before_action :set_booking, only: [:show, :update, :destroy]
  require 'date'
  require 'active_support/core_ext'

  # GET /bookings.json
  def index
    if !current_user?
      @bookings = Booking.all
      render json: @bookings
    else
      render json: current_user.bookings
    end
  end

  # GET /bookings/1.json
  def show
     render json: @booking
  end

  # GET /bookings/new
  # def new
  #   @booking = current_user.bookings.build
  # end

  # GET /bookings/1/edit
  # def edit
  # end

  # POST /bookings.json
  def create
    invalid_booking = false
    # puts booking_params
    duration =  params[:booking][:duration].to_i
    quantity =  params[:booking][:quantity].to_i
    bk_day = params[:booking][:booking_day]
    bk_day = Date.strptime(bk_day, '%Y-%m-%d')
    last_day = bk_day + duration.days
    room = params[:booking][:room_id]
    @bookings = []
    @availability_update = []

    #Check Availability for  room on each day and given quantity.
    #If all available for all days, create bookings and save.
    #Reduce Availability quantity for each day.

  (bk_day..last_day).each {|day|
    available = Availability.where(available_day:day).where(room_id:room).where("quantity>?",quantity).first

    if available
      #build on params and given date.
      #then add to array of bookings/
      @booking = current_user.bookings.build(booking_params)
      @booking.booking_day = day
      @bookings << @booking
      available.quantity = available.quantity - quantity
      @availability_update << available
    else
      invalid_booking = true
      break
    end
   }

    if !invalid_booking
      @bookings.each(&:save!)
      @availability_update.each(&:save!)
       render :json => current_user.bookings, status: :created
    else
      puts 'invalid booking'
         render :json => current_user.bookings, status: :unprocessable_entity
    end

  end


  # PATCH/PUT /bookings/1.json
  def update
      if @booking.booking_day>Date.today && @booking.update(booking_params)
        render :show, status: :ok, location: @booking
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
  end


  # DELETE /bookings/1.json
  def destroy
    @availability  = @booking.room.availabilities.where(available_day:@booking.booking_day).first
    updated_quantity = @availability.quantity + @booking.quantity
    @booking.destroy
    @availability.update(quantity:updated_quantity)

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end
    def booking_params
      params.require(:booking).permit(:user_id,:booking_day, :duration, :quantity, :room_id)
    end

end
