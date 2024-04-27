# == Schema Information
#
# Table name: trip_events
#
#  id         :bigint           not null, primary key
#  trip_id    :bigint           not null
#  creator_id :integer
#  name       :string
#  category   :string           default("Not Specified")
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TripEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
