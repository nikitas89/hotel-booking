class ApplicationController < ActionController::Base
  # protect_from_forgery with: null_session

  include Knock::Authenticable
  # include ActionController::Serialization

  # before_action :authenticate

 protected

 # Method for checking if current_user is admin or not.
 def authorize_as_admin
   return_unauthorized unless !current_user.nil? && current_user.is_admin?
 end
end
