class ApplicationController < ActionController::Base
  include Knock::Authenticable
  protect_from_forgery with: :exception

 protected

 # Method for checking if current_user is admin or not.
 def authorize_as_admin
   return_unauthorized unless !current_user.nil? && current_user.is_admin?
 end
end
