class FriendshipsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_friend, only: %i[create]

  def create
    @friendship = Friendship.new
    @friendship.user = @user
    @friendship.friend = @friend

    if @friendship.save
      flash.now[:notice] = 'Invitation Sent 🎉'

      respond_to do |format|
        format.html { flash.now[:notice] = 'Invitation Sent 🎉' }
        format.turbo_stream
      end
    end

    authorize @user, policy_class: FriendshipPolicy
  end

  private

  def set_user
    @user = current_user
  end

  def friendship_params
    params.require(:friendship).permit(friendship: :friend_id)
  end

  def set_friend
    @friend = User.find(params[:friendship][:friend_id])
  end
end
