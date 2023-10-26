class TripsController < ApplicationController
  def index
    @trips = @user.trips
  end
end
