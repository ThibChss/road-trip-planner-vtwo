class FriendshipsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_friend, only: %i[create]

  def create
    @friendship = Friendship.new
    @friendship.user = @user
    @friendship.friend = @friend

    if @friendship.save
      @suggestions = @user.friends_suggestions
      flash.now[:notice] = "Invitation sent to #{@friend.first_name.capitalize} 🎉"
      render turbo_stream: [
        turbo_stream.remove("friend_item_#{@friend.id}"),
        turbo_stream.append(
          :flash,
          partial: 'shared/flash_message'
        )
      ]
    else
      flash.now[:alert] = 'Something went wrong ❌'
      render turbo_stream: turbo_stream.append(
                              :flash,
                              partial: 'shared/flash_message'
                            )
    end

    authorize @user, policy_class: FriendshipPolicy
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friend = @friendship.friend
    @friendship.destroy

    flash.now[:alert] = "Cancel invitation to #{@friend.first_name.capitalize} 👋🏻"

    render turbo_stream: [
      turbo_stream.remove("friend_item_#{@friend.id}"),
      turbo_stream.append(
        :flash,
        partial: 'shared/flash_message'
      )
    ]

    authorize @user, policy_class: FriendshipPolicy
  end

  private

  def set_user
    @user = current_user
  end

  def set_friend
    @friend = User.find(params[:friendship][:friend_id])
  end

  def friendship_params
    params.require(:friendship).permit(friendship: :friend_id)
  end
end
