class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?

  private

  def redirect_signed_in_user!
    redirect_to profile_path(current_user) if user_signed_in?
  end

  def redirect_nil_user!
    redirect_to profile_path(current_user), alert: "This person doesn't exist 👤"
  end

  def redirect_unauthorized_user!
    redirect_to profile_path(current_user), alert: "You do not have acces to #{@user.username}'s profile 🚫"
  end

  def in_turbo_frame?
    redirect_to profile_path(@user), alert: "Cannot find this page" unless request.headers['Turbo-Frame']
  end

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
