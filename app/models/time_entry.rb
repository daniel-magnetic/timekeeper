# encapsulates a checkin / checkout time that gets recorded on a user's #Timecard.
# there can be 2 entries on a time card.
# this model handles updating a timecard's total hours iff there is a complete pair.
# the timecard must exist before this can be saved
class TimeEntry < ApplicationRecord
  TOTAL_HOURS_SCALE = 3
  # TODO should probably add referencial integrity to the database to enforce this too. need a migration for that
  belongs_to :timecard

  validates :time, presence: true
  # make sure a valid timecard was specified
  validates :timecard, presence: true

  # validate that max of 2 entries can belong to a single card
  validate :validate_max_2, on: :create

  # update the linked card's cache of the time difference between the two entries
  after_destroy :clear_card_totalhours
  after_save :update_card_totalhours

  def validate_max_2
    #if there is a time card, check that it doesnt have a pair of entries already
    if !timecard.nil? && timecard.time_entries.count > 1
      errors.add(:timecard, "The time card is already saturated with 2 entries.")
    end
  end

  # this entry has been saved so we might need to update the timecard total hours
  def update_card_totalhours
    if timecard.time_entries.count == 2
      # yup there is a pair of entries
      # grab the times of each entry and calculate the difference to add to the time card
      times = timecard.time_entries.pluck(:time)
      timecard.totalhours = ((times[1] - times[0]) / 3600).round(TOTAL_HOURS_SCALE)
    else
      # not a pair
      # make sure the total hours is nil
      timecard.totalhours = nil
    end
    timecard.save
  end

  # this entry is being deleted so we should wipe the total hours
  def clear_card_totalhours
    unless timecard.totalhours.nil?
      timecard.totalhours = nil
      timecard.save
    end
  end
end
