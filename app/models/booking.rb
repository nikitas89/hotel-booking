class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

#def is_before_start
#@booking.booking_day>Date.today
#end
def build_booking
  @booking = current_user.bookings.build(booking_params)
  @booking.booking_day = day
end

end
