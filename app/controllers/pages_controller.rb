class PagesController < ApplicationController
  # Does not require to be connected on the homepage
  skip_before_action :authenticate_user!, only: :home
  # If user is already signed in => Does not allow access to this page
  before_action :redirect_signed_in_user!, only: :connect
  # Find the user first
  before_action :set_user, only: %i[profile friends pending_friends invitations search_friends]
  # Check if user exist and redirect if not
  before_action :user_exists?, only: %i[profile friends pending_friends invitation search_friends]
  # Define the page limit and the current page
  before_action :define_page, only: %i[friends pending_friends invitations search_friends]
  # If user exist check if it is authorized
  before_action :authorize_user!, only: %i[profile friends]
  # Authorize only the current_user
  before_action :authorize_current_user_only!, only: %i[pending_friends invitations search_friends]
  # Check if the page is rendered in a turbo frame
  before_action :in_turbo_frame?, only: %i[friends pending_friends invitations]

  def home; end

  def profile; end

  def connect; end

  def friends
    @user_friends = @user.friends.where.not(id: current_user)

    if params[:query].present?
      @query = params[:query]
      @friends = @user_friends.search_user(params[:query]).offset(@page_limit * @current_page).limit(@page_limit).uniq
      @next_page = @current_page + 1 if @user_friends.search_user(params[:query]).count > (@page_limit * @current_page) + @page_limit
    else
      @friends = @user_friends.offset(@page_limit * @current_page).limit(@page_limit).uniq
      @next_page = @current_page + 1 if @user_friends.count > (@page_limit * @current_page) + @page_limit
    end
  end

  def pending_friends
    @user_sent_requests = @user.sent_friends.where.not(id: current_user)

    @pending_friends = @user_sent_requests.offset(@page_limit * @current_page).limit(@page_limit)
    @next_page = @current_page + 1 if @user_sent_requests.count > (@page_limit * @current_page) + @page_limit
  end

  def invitations
    @user_received_friends = @user.received_friends.where.not(id: current_user)

    @invitations = @user_received_friends.offset(@page_limit * @current_page).limit(@page_limit)
    @next_page = @current_page + 1 if @user_received_friends.count > (@page_limit * @current_page) + @page_limit
  end

  def search_friends
    @user_suggestions = @user.friends_suggestions

    if params[:query].present?
      @query = params[:query]
      @suggestions = @user_suggestions.search_user(@query).offset(@page_limit * @current_page).limit(@page_limit).uniq
      puts @suggestions.empty?
      @next_page = @current_page + 1 if @user_suggestions.search_user(@query).count > (@page_limit * @current_page) + @page_limit
    else
      @suggestions = @user_suggestions.offset(@page_limit * @current_page).limit(@page_limit).uniq
      @next_page = @current_page + 1 if @user_suggestions.count > (@page_limit * @current_page) + @page_limit
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:slug])
  end

  def authorize_user!
    return redirect_unauthorized_user! unless PagesControllerPolicy.new(current_user, @user).check_friends?

    authorize @user, policy_class: PagesControllerPolicy
  end

  def authorize_current_user_only!
    return redirect_unauthorized_user! unless PagesControllerPolicy.new(current_user, @user).user_record?

    authorize @user, policy_class: PagesControllerPolicy
  end

  def user_exists?
    redirect_nil_user! if @user.nil?
  end

  def define_page
    @page_limit = 8
    @current_page = params[:page].to_i
  end
end
