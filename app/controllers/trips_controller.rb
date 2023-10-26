class TripsController < ApplicationController
  # Find the user first
  before_action :set_user, only: %i[index]
  # Check if user exist and redirect if not
  before_action :user_exists?, only: %i[index]
  # Check if the page is rendered in a turbo frame
  before_action :in_turbo_frame?, only: %i[index]

  def index
    @trips = policy_scope(@user.trips).order(start_date: :asc)

    authorize @trips
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
