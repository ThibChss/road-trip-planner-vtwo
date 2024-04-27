# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  status     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  after_create :update_mutual_friendship_status

  private

  def update_mutual_friendship_status
    if self.class.exists?(user: friend, friend: user)
      self.class.where(user: friend, friend: user).update_all(status: true)
      update(status: true)
    else
      update(status: false)
    end
  end
end
