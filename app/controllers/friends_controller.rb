class FriendsController < ApplicationController
  # Find the user first
  before_action :set_user, only: %i[friends pending_friends invitations search_friends]

  # Authorization for different actions
  before_action :authorize_for_action, only: %i[friends pending_friends invitations search_friends]

  # Check if the page is rendered in a turbo frame
  before_action :in_turbo_frame?, only: %i[friends pending_friends invitations search_friends]

  def friends
    @friends = @user.friends.where.not(id: current_user.id).order(first_name: :asc)

    paginate_friends
  end

  def pending_friends
    @friends = @user.sent_friends.where.not(id: current_user).order(created_at: :desc)

    paginate_friends
  end

  def invitations
    @friends = @user.received_friends.where.not(id: current_user).order(created_at: :desc)

    paginate_friends
  end

  def search_friends
    @friends = @user.friends_suggestions.order(first_name: :asc)

    paginate_friends
  end

  private

  def authorize_for_action
    policy = FriendsControllerPolicy.new(current_user, @user)

    case action_name
    when :friends
      return redirect_unauthorized_user! unless policy.check_friends?
    when :pending_friends, :invitations, :search_friends
      return redirect_unauthorized_user! unless policy.user_record?
    end

    authorize @user, policy_class: FriendsControllerPolicy
  end

  def paginate_friends
    @page_limit = 8
    @current_page = params[:page].to_i
    @query = params[:query].presence

    if @query
      @results = @friends.search_user(@query)

      @friends = @results.decorate.offset(@page_limit * @current_page).limit(@page_limit)
      @next_page = @current_page + 1 if @results.size > (@page_limit * @current_page) + @page_limit
    else
      @results = @friends

      @friends = @friends.decorate.offset(@page_limit * @current_page).limit(@page_limit)
      @next_page = @current_page + 1 if @results.size > (@page_limit * @current_page) + @page_limit
    end
  end
end
