# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  trip_event_id :bigint           not null
#  address       :string
#  longitude     :float
#  latitude      :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Address < ApplicationRecord
  belongs_to :trip_event
end
