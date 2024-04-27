# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  trip_id    :bigint           not null
#  admin      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
