#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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

Room.create(roomType:'Suite Apartment',
  description:'Beach facing view, large room',
  image:'https://pix6.agoda.net/hotelImages/165/165214/165214_17092614410056806986.jpg',
  quantity:3, price:200)
Room.create(roomType:'3 Bedroom Suite',
  description:'smoking City view 154 m²/1658 ft² 2 bathrooms Shower and bathtub Balcony/terrace	',
  image:'https://pix6.agoda.net/hotelImages/165/165214/165214_17063017290054188953.jpg',
  quantity:3, price:134.00)
Room.create(roomType:'2 Bedroom Suite',
  description:'deluxe suite for our guests',
  image:'https://therantingpanda.files.wordpress.com/2015/01/img_4217.jpg?w=940',
  quantity:5, price:400.00)
Room.create(roomType:'Studio Premiere',
  description:'City view 37 m²/398 ft²',
  image:'https://pix6.agoda.net/hotelImages/165/165214/165214_17092614060056805901.jpg?s=1024x768',
  quantity:1, price:147.00)


require 'date'
end_date = Date.today + 30
date_range = Date.today..end_date

date_range.each {|date|
  Room.all.each do |room|
    room.availabilities.create(available_day: date, quantity: room.quantity)
  end

}
