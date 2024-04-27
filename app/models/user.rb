class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  pg_search_scope :search_user,
                  against: %i[username first_name last_name],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # Trips created
  has_many :trips_created, class_name: :Trip

  # Trips to which user participate
  has_many :participating, class_name: :Participant, dependent: :destroy
  has_many :trips, through: :participating

  # Events in trips that user created
  has_many :trip_events_created, class_name: :TripEvent, foreign_key: :creator_id

  # Mutual friendships and mutual friends details
  has_many :friendships, -> { where(status: true) }
  has_many :friends, through: :friendships

  # Sent friendships requests and sent friends details
  has_many :sent_friendships_requests, -> { where(status: false).order(created_at: :desc) }, class_name: :Friendship
  has_many :sent_friends, through: :sent_friendships_requests, source: :friend

  # Friends suggestions

  # Received friendships requests and received friends details
  has_many  :received_friendships_requests, -> { where(status: false).order(created_at: :desc) },
            class_name: :Friendship, foreign_key: :friend_id
  has_many  :received_friends, through: :received_friendships_requests, source: :user

  # Basic validations
  validates :first_name, :last_name, :username, :email, presence: true
  validates :email, :username, uniqueness: { case_sensitive: true }

  # Methods related to user's trips
  def trips_in_common(user)
    trips & user.trips
  end

  # Methods for friends
  def friends_in_common(user)
    friends & user.friends
  end

  def friend?(user)
    friends.include?(user)
    # Participant.joins(:user, :trip).where(users: { id: self }).where(trip: Trip.joins(:participants).where(participants: { id: user })).pluck(:trip_id)
  end

  def friendship_relation_exist?(user)
    !friend?(user) && !user.sent_friends.include?(self) && !user.received_friends.include?(self)
  end

  def friends_suggestions
    self.class.where.not(id: self).where.not(id: sent_friends).where.not(id: received_friends).where.not(id: friends)
  end

  def find_friendship(friend)
    sent_friendships_requests.find_by(friend:)
  end
end
