# == Schema Information
#
# Table name: trips
#
#  id         :bigint           not null, primary key
#  name       :string
#  start_date :date
#  end_date   :date
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default("pending")
#  photo_url  :string
#  slug       :string
#
class Trip < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user # The user who created the trip

  # Events belonging to a trip
  has_many :events, class_name: :TripEvent, dependent: :destroy
  has_many :expenses, through: :events, source: :price

  # Find instances of participants in the trip
  has_many :participations, class_name: :Participant, dependent: :destroy
  has_many :participants, through: :participations, source: :user
  # Allow creation of participation when creating a trip
  accepts_nested_attributes_for :participations,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Find the admins of the trip
  has_many :admins, -> { where(admin: true) }, class_name: :Participant

  enum :status, %i[confirmed pending cancelled]

  validates :name, :start_date, :end_date, :user, presence: true

  validate :validate_end_date

  after_create :set_creator_as_admin

  pg_search_scope :search_trip,
                  against: %i[name],
                  associated_against: {
                    participants: %i[first_name last_name username]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def balance
    @balance ||= BalanceCalculator.call(expenses)
  end

  private

  def set_creator_as_admin
    participations.create!(user:, admin: true)
  end

  def validate_end_date
    return if end_date.nil? || start_date.nil?

    errors.add(:end_date, 'cannot be before the start date') if end_date < start_date
  end
end
