class TripsController < ApplicationController
  # Find the user first
  before_action :set_user, only: %i[index]
  # Check if user exist and redirect if not
  before_action :user_exists?, only: %i[index]
  # Check if the page is rendered in a turbo frame
  before_action :in_turbo_frame?, only: %i[index new]
  # Find the current trip
  before_action :set_trip, only: %i[show]

  def index
    @page_limit = 9
    @current_page = params[:page].to_i
    @user_trips = policy_scope(@user.trips).order(start_date: :asc)
    authorize @user_trips
    p params[:source_frame]

    if params[:query].present?
      @query = params[:query]
      @trips = @user_trips.search_trip(params[:query]).offset(@page_limit * @current_page).limit(@page_limit)
      @next_page = @current_page + 1 if @user_trips.search_trip(params[:query]).count > (@page_limit * @current_page) + @page_limit
    else
      @trips = @user_trips.offset(@page_limit * @current_page).limit(@page_limit)
      @next_page = @current_page + 1 if @user_trips.count > (@page_limit * @current_page) + @page_limit
    end
  end

  def show
    authorize @trip
  end

  def new
    @trip = Trip.new

    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @admin = Participant.create(trip: @trip, user: current_user, admin: true)

    if @trip.save
      # redirect_to profile_path(current_user), notice: 'Your trip has been added 🌴'
      # p params[:source_frame]
      # respond_to do |format|
      #   format.html { redirect_to trips_index_path(current_user) }
      #   format.turbo_stream
      # end
    else
      render :new, status: :unprocessable_entity, alert: 'Something went wrong❗'
    end

    authorize @trip
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
