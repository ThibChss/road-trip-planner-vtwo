# == Schema Information
#
# Table name: prices
#
#  id            :bigint           not null, primary key
#  paid_by_id    :integer
#  trip_event_id :bigint           not null
#  total_paid    :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Price < ApplicationRecord
  belongs_to :trip_event
  belongs_to :paid_by, class_name: :User

  has_many :paid_for_trip_events, dependent: :destroy
  has_many :paid_for, through: :paid_for_trip_events, source: :user
end
