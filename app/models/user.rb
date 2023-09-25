class User < ApplicationRecord
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
  has_many :friends, -> { order(first_name: :asc) }, through: :friendships

  # Sent friendships requests and sent friends details
  has_many :sent_friendships_requests, -> { where(status: false).order(created_at: :desc) }, class_name: :Friendship
  has_many :sent_friends, through: :sent_friendships_requests, source: :friend

  # Received friendships requests and received friends details
  has_many  :received_friendships_requests, -> { where(status: false).order(created_at: :desc) },
            class_name: :Friendship, foreign_key: :friend_id
  has_many  :received_friends, through: :received_friendships_requests, source: :user

  # Basic validations
  validates :first_name, :last_name, :username, :email, presence: true
  validates :email, :username, uniqueness: true
  after_create :set_slug
  validates :slug, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_param
    slug
  end

  private

  def set_slug
    update(slug: username.slugify)
  end
end
