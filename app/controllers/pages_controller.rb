class PagesController < ApplicationController
  # Does not require to be connected on the homepage
  skip_before_action :authenticate_user!, only: :home

  # If user is already signed in => Does not allow access to this page
  before_action :redirect_signed_in_user!, only: :connect

  # Find the user first
  before_action :set_user, only: %i[profile]

  # If user exist check if it is authorized
  before_action :authorize_user!, only: %i[profile]

  def home; end

  def profile; end

  def connect; end

  private

  def authorize_user!
    return redirect_unauthorized_user! unless PagesControllerPolicy.new(current_user, @user).check_friends?

    authorize @user, policy_class: PagesControllerPolicy
  end

  def authorize_current_user_only!
    return redirect_unauthorized_user! unless PagesControllerPolicy.new(current_user, @user).user_record?

    authorize @user, policy_class: PagesControllerPolicy
  end
end
