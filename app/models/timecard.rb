# encapsulates a users list of on/off times
# there can only be 2 entries so each card for a single pair of in / out times
# #TimeEntry will handle updating the total hours that are stored in this object
class Timecard < ApplicationRecord
  has_many :time_entries, -> { order(:time) }, dependent: :destroy
  # username should probably be unique and the params should probably be present
  validates :username, uniqueness: true, presence: true
  validates :occurrence, presence: true
end
