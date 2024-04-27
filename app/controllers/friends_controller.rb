class FriendsController < ApplicationController
  # Find the user first
  before_action :set_user, only: %i[friends pending_friends invitations search_friends]

  # Set page limit and define current page
  before_action :define_page, only: %i[friends pending_friends invitations search_friends]

  # If user exist check if it is authorized
  before_action :authorize_user!, only: %i[friends]

  # Authorize only the current_user
  before_action :authorize_current_user_only!, only: %i[pending_friends invitations search_friends]

  # Check if the page is rendered in a turbo frame
  before_action :in_turbo_frame?, only: %i[friends pending_friends invitations search_friends]

  def friends
    @user_friends = @user.friends.where.not(id: current_user).order(first_name: :asc)

    if params[:query].present?
      @query = params[:query]
      @friends = @user_friends.search_user(params[:query]).offset(@page_limit * @current_page).limit(@page_limit).decorate
      @next_page = @current_page + 1 if @user_friends.search_user(params[:query]).count > (@page_limit * @current_page) + @page_limit
    else
      @friends = @user_friends.offset(@page_limit * @current_page).limit(@page_limit).decorate
      @next_page = @current_page + 1 if @user_friends.count > (@page_limit * @current_page) + @page_limit
    end
  end

  def pending_friends
    @user_sent_requests = @user.sent_friends.where.not(id: current_user).order(created_at: :desc).decorate

    @pending_friends = @user_sent_requests.offset(@page_limit * @current_page).limit(@page_limit)
    @next_page = @current_page + 1 if @user_sent_requests.count > (@page_limit * @current_page) + @page_limit
  end

  def invitations
    @user_received_friends = @user.received_friends.where.not(id: current_user).order(created_at: :desc).decorate

    @invitations = @user_received_friends.offset(@page_limit * @current_page).limit(@page_limit)
    @next_page = @current_page + 1 if @user_received_friends.count > (@page_limit * @current_page) + @page_limit
  end

  def search_friends
    @user_suggestions = @user.friends_suggestions.order(first_name: :asc)

    if params[:query].present?
      @query = params[:query]
      @suggestions = @user_suggestions.search_user(@query).offset(@page_limit * @current_page).limit(@page_limit).decorate
      @next_page = @current_page + 1 if @user_suggestions.search_user(@query).count > (@page_limit * @current_page) + @page_limit
    else
      @suggestions = @user_suggestions.offset(@page_limit * @current_page).limit(@page_limit).decorate
      @next_page = @current_page + 1 if @user_suggestions.count > (@page_limit * @current_page) + @page_limit
    end
  end

  private

  def authorize_user!
    return redirect_unauthorized_user! unless FriendsControllerPolicy.new(current_user, @user).check_friends?

    authorize @user, policy_class: FriendsControllerPolicy
  end

  def authorize_current_user_only!
    return redirect_unauthorized_user! unless FriendsControllerPolicy.new(current_user, @user).user_record?

    authorize @user, policy_class: FriendsControllerPolicy
  end

  def define_page
    @page_limit = 8
    @current_page = params[:page].to_i
  end
end
