Rails.application.routes.draw do
  resources :rooms
get '/availabilities/:date' => 'availabilities#show'
  resources :availabilities

end
