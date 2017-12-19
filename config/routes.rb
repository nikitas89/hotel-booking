Rails.application.routes.draw do
  resources :rooms
  resources :availabilities
  post 'user_token' => 'user_token#create'
  get '/availabilities/:date' => 'availabilities#show'
  resources :users

end
