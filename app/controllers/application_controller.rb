class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    profile_path
  end

  def correct_connexion_path?
    request.original_fullpath == connexion_path ||
      request.original_fullpath == new_user_session_path ||
      request.original_fullpath == new_user_registration_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to connexion_path unless correct_connexion_path?
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :first_name, :last_name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username,
                                                                      :first_name,
                                                                      :last_name,
                                                                      :email,
                                                                      :password,
                                                                      :current_password) }
  end
end
