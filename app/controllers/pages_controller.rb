class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :redirect_signed_in_user!, only: :connect

  def home; end

  def profile
    @user = User.find_by(slug: params[:slug])
    return redirect_to profile_path(current_user), alert: "This person doesn't exist 👤" if @user.nil?

    @authorize = PagesControllerPolicy.new(current_user, @user).profile?

    if @user && @authorize
      authorize @user, policy_class: PagesControllerPolicy
    else
      redirect_to profile_path(current_user), alert: "You do not have acces to #{@user.username}'s profile 🚫"
    end
  end

  def connect; end

  private

  def redirect_signed_in_user!
    redirect_to profile_path(current_user) if user_signed_in?
  end
end
