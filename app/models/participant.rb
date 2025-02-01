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
class Participant < ApplicationRecord
  # attr_accessible :user_ids

  belongs_to :user
  belongs_to :trip

  validates :user, uniqueness: { scope: :trip }
end
