# Hotel Booking API on Rails 5, Postgresql

## Features
CMS for admin for CRUD of rooms
API
1. List rooms availability for all, day and range
2. Book rooms for multiple quantity and days
3. Cancel/Edit bookings 


## How to use - locally
1. rails db:setup
2. rails db:seed (adds admin, user, and availabilities data)
3. rails s

## Front end usage guide
1. Postico
Post request for login format
Body, raw, must be json type.
```
{"auth": {"email": "user@hotelbooking.com", "password" : "test123"}}
```

  User:
  user@hotelbooking.com
  test123

2. Sign up:
```
{"user":{"email":"nikita@hotelbooking.com", "password_digest":"tester123"}}
```

3. Send booking creation data
```
booking[booking_day]:"2017-12-24"
booking[duration]:4
booking[quantity]:5
booking[room_id]:2
```

## API Endpoints
```
  GET  / => rooms#index
  Show all rooms - auth not required in test

  POST /user_token
  Sign in as user and get token

  GET /availabilities
  Show all room availabilities

  GET /availabilities/2017-12-23
  Show room availabilities for one day

  GET /availabilities/range/:dates
  e.g. /availabilities/range/2017-12-23&2017-12-24
  Show room availabilities in range
```
```
  Index bookings:
  Get /bookings

  Show booking
  GET /bookings/:id
```
```
***USER TOKEN MUST BE SET IN HEADER ***
  To Create Bookings:
  POST /bookings
  Header:
  Authorization with Bearer token,
  Accept: application/json, text/plain, */*,
  Content-Type:[{"key":"Content-Type","value":"application/json","description":"","enabled":true}]
  Form Body: booking[booking_day], booking[duration], booking[quantity], booking[room_id]  

  Update booking
  PATCH/PUT /bookings/:id
  Same as POST; only use fields to be updated

  Delete booking
  Delete /bookings/:id
  Set Header to be same as POST

```
Non-authenticated actions are Read-only
