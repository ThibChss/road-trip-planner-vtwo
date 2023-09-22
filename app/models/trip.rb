class Trip < ApplicationRecord
  belongs_to :user

  # Get some informations from the associated class and can use them like 'user_first_name'
  # Just a test => NOT needed here
  # delegate :first_name, :last_name, to: :user, prefix: true

  has_many :events, class_name: :TripEvent, dependent: :destroy
  has_many :participations, class_name: :Participant, dependent: :destroy
  has_many :participants, through: :participations, source: :user
  has_many :admins, -> { where(admin: true) }, class_name: :Participant

  enum status: %i[confirmed pending cancelled]

  validates :name, :start_date, :end_date, :user, presence: true

  validate :validate_end_date

  private

  def validate_end_date
    return if end_date.nil? || start_date.nil?

    errors.add(:end_date, 'cannot be before the start date') if end_date < start_date
  end
end
