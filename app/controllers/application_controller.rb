class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?

  protected

  def correct_connect_path?
    request.original_fullpath == connect_path ||
      request.original_fullpath == new_user_session_path ||
      request.original_fullpath == new_user_registration_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to connect_path unless correct_connect_path?
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
