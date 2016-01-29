class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # name/email devise auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_admin_user!
    if user_signed_in?
      redirect_to new_user_session_path unless current_user.admin == true
    else
      redirect_to articles_path
    end
  end

  protected

  # name/email devise auth
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

end
