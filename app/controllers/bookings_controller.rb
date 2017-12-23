class BookingsController < ApplicationController
  before_action :authenticate_user
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  require 'date'
  require 'active_support/core_ext'
  # GET /bookings
  # GET /bookings.json
  def index
    if current_user.admin?
      @bookings = Booking.all
      #dont show user details in response
      render json: @bookings, :except => [:user]
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    # render json: Booking.find(params[:id]), :except => [:user]
     #how to do except user?
     render json: set_booking
  end

  # GET /bookings/new
  def new
    @booking = current_user.bookings.build
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    invalid_booking = false
    puts booking_params
    duration =  params[:booking][:duration].to_i
    quantity =  params[:booking][:quantity].to_i
    bk_day = params[:booking][:booking_day]
    bk_day = Date.strptime(bk_day, '%Y-%m-%d')
    last_day = bk_day + duration.days
    room = params[:booking][:room_id]
    @bookings = []
    @availability_update = []

      #check Availability for  room on each day and given quantity
      #22-12 - dont cater to mutiple room types in one post
      #if all availble for all days, create bookings and save. Reduce availaility quantity for each day.


    (bk_day..last_day).each {|day|
      available = Availability.where(available_day:day).where(room_id:room).where("quantity>?",quantity).first

      if available
        puts available.id
        #build on params and given date.
        @booking = current_user.bookings.build(booking_params)
        @booking.booking_day = day
        #then add to array of bookings
        @bookings << @booking
        available.quantity = available.quantity - quantity.to_i
        @availability_update << available
      else
        invalid_booking = true
        puts day
        puts 'not available'
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

    # respond_to do |format|
    #   if @bookings.save
    #     format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
    #     format.json { render :show, status: :created, location: @booking }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @booking.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    #TODO transaction. rollbackk if one fails.
    # update ava record to add quantity from booking
    set_booking
    @availability  = @booking.room.availabilities.where(available_day:@booking.booking_day).first
    puts @availability
    puts @availability.to_s
    # @availability.quantity = @availability.quantity + @booking.quantity
    updated_quantity = @availability.quantity + @booking.quantity
    # puts @availability.quantity
    @booking.destroy
    @availability.update(quantity:updated_quantity)
    @availability.save

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end
#http://vicfriedman.github.io/blog/2015/07/18/create-multiple-objects-from-single-form-in-rails/
    def booking_params
      #:user_id, not sure to remove or include. did not get error either way.
      params.require(:booking).permit(:user_id,:booking_day, :duration, :quantity, :room_id)
    end
end
