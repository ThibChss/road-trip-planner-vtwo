# == Schema Information
#
# Table name: paid_for_trip_events
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  price_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaidForTripEvent < ApplicationRecord
  belongs_to :user
  belongs_to :price
end
