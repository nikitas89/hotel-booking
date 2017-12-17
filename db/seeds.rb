#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#for each room. create availaility for each day.
#ava: id.  available day. quantity mathces room's quantity.
#booking.

require 'date'

end_date = Date.today + 30
date_range = Date.today..end_date

date_range.each {|date|
  Room.all.each do |room|
    room.availabilities.create(available_day: date, quantity: room.quantity)
  end

}


# (10..15).each {|n| print n, ' ' }
