class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

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
end
