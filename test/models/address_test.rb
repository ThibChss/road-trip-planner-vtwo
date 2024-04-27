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
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
