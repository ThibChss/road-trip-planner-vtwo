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
require "test_helper"

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
