class Price < ApplicationRecord
  belongs_to :trip_event
  belongs_to :paid_by, class_name: :User

  has_many :paid_for_trip_events, dependent: :destroy
  has_many :paid_for, through: :paid_for_trip_events, source: :user
end
