#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#for each room. create availaility for each day.
#ava: id.  available day. quantity mathces room's quantity.
#booking.

admin = Admin.new
admin.email = 'admin_manager@hotelbooking.com'
admin.password = 'tester123'
admin.password_confirmation = 'tester123'
admin.save

user = User.new
user.email = 'user@hotelbooking.com'
user.password = 'test123'
user.password_confirmation = 'test123'
user.save


require 'date'
end_date = Date.today + 30
date_range = Date.today..end_date

date_range.each {|date|
  Room.all.each do |room|
    room.availabilities.create(available_day: date, quantity: room.quantity)
  end

}
