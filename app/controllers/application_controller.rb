require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ---- methods ----

  def go_home
    if user_signed_in?
      redirect_to passwords_path
    else
      redirect_to new_user_session_path
    end
  end

  def user
    render json: current_user.try(:to_hash)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :gender_id, :user_type_id, :password, :confirm_password])
  end
end
