class Participant < ApplicationRecord
  # attr_accessible :user_ids

  belongs_to :user
  belongs_to :trip
end
