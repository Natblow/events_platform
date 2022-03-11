# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #     super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource_or_scope)
    if session[:creating_attendee]
      redirect_to_event
    else
      super
    end
  end

  def redirect_to_event
    previous_url = session[:previous_url]
    clear_sessions_and_set_new_one
    previous_url #redirect
  end

  def clear_sessions_and_set_new_one
    session[:creating_attendee] = nil #clear session
    session[:previous_url] = nil #clear session
    session[:login_successful_for_attend] = true
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
