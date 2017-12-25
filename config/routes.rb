Rails.application.routes.draw do

  resources :bookings
  resources :rooms
  resources :availabilities
  get '/availabilities/:date' => 'availabilities#show'
  get '/availabilities/range/:dates' => 'availabilities#show_range'
  resources :users
  root   'rooms#index'
  get    'auth'  => 'rooms#auth'
  # Get login token from Knock
  # mount Knock::Engine => "/knock"
  post 'user_token' => 'user_token#create'

end
