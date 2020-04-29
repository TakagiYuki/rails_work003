class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception#csrf

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end


