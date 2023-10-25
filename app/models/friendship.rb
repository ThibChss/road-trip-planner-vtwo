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
