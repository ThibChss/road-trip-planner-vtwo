class FriendshipsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_friend, only: %i[create]
  before_action :set_friendship, only: %i[destroy remove]

  def create
    @friendship = Friendship.new
    @friendship.user = @user
    @friendship.friend = @friend

    if @friendship.save
      @suggestions = @user.friends_suggestions
      flash.now[:notice] = params[:friendship][:action].empty? ? "Invitation sent to #{@friend.first_name.titleize} 🎉" : "Confirm invitation from #{@friend.first_name.titleize} 🎉"
      turbo_stream_action_success
    else
      flash.now[:alert] = 'Something went wrong ❌'
      render turbo_stream: turbo_stream_flash_message
    end

    authorize @user, policy_class: FriendshipPolicy
  end

  # Destroy sent friend request
  def destroy
    @friend = @friendship.friend
    @friendship.destroy

    flash.now[:alert] = "Cancel invitation to #{@friend.first_name.titleize} 👋🏻"
    turbo_stream_action_success

    authorize @user, policy_class: FriendshipPolicy
  end

  # Destroy received invitation
  def remove
    @friend = @friendship.user
    @friendship.destroy

    flash.now[:alert] = "Remove invitation from #{@friend.first_name.titleize} 👋🏻"
    turbo_stream_action_success

    authorize @user, policy_class: FriendshipPolicy
  end

  # Destroy mutual friendships
  def remove_mutual
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    @friendships = Friendship.where(user: [@user, @friend], friend: [@user, @friend])
    @friendships.destroy_all

    flash.now[:alert] = "#{@friend.first_name.titleize} removed from your friend list 👋🏻"
    turbo_stream_action_success

    authorize @user, policy_class: FriendshipPolicy
  end

  private

  def set_user
    @user = User.find(params[:friendship][:user_id])
  end

  def set_friend
    @friend = User.find(params[:friendship][:friend_id])
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(friendship: %i[friend_id user_id action])
  end

  def turbo_stream_flash_message
    turbo_stream.append(
      :flash,
      partial: 'shared/flash_message'
    )
  end

  def turbo_stream_action_success
    render turbo_stream: [
      turbo_stream.remove("friend_item_#{@friend.id}"),
      turbo_stream_flash_message
    ]
  end
end
