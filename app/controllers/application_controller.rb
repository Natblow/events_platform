class ApplicationController < ActionController::Base
  protect_from_forgery
      rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = exception.message
        redirect_to root_url
      end

  # def after_sign_in_path_for(resource)
  #   # if session[:user_return_to] == nil
  #   #   your_actual_next_path
  #   # else
  #   #   super
  #   # end
  # end
end
