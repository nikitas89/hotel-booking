Rails.application.routes.draw do


  devise_for :admins
  resources :admins, except: [:destroy, :edit, :update, :show  ]
  resources :bookings
  resources :rooms
  get '/availabilities/:date' => 'availabilities#show'
  get '/availabilities/range/:dates' => 'availabilities#show_range'
  resources :availabilities
  resources :users
  root   'rooms#index'
  get    'auth'  => 'rooms#auth'
  post 'user_token' => 'user_token#create'

end
