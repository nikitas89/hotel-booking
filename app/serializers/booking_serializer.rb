class BookingSerializer < ActiveModel::Serializer
  attributes :id, :booking_day, :duration, :quantity
  has_one :user
  has_one :room
end
