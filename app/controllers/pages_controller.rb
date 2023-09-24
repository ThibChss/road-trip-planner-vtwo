class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :redirect_signed_in_user, only: :connexion

  def home; end

  def profile; end

  def connexion; end

  private

  def redirect_signed_in_user
    redirect_to profile_path(current_user) if user_signed_in?
  end
end
