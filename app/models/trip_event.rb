class TripEvent < ApplicationRecord
  belongs_to :trip
  belongs_to :creator, class_name: :User

  has_many :addresses, dependent: :destroy
  has_one :price, dependent: :destroy

  validates :trip, :creator, :name, :start_date, :end_date, presence: true

  validate :dates_are_valid

  private

  def dates_within_trip_timeline?
    !start_date.between?(trip.start_date, trip.end_date) && !end_date.between?(trip.start_date, trip.end_date)
  end

  def dates_are_valid
    if start_date.nil? || end_date.nil?
      errors.add(:start_date, 'and end date are required')
    elsif end_date < start_date
      errors.add(:end_date, 'cannot be before the start date')
    elsif dates_within_trip_timeline?
      errors.add(:start_date, 'and end date must be between the trip start and end dates')
    end
  end
end
