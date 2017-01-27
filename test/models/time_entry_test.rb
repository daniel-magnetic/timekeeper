require 'test_helper'

class TimeEntryTest < ActiveSupport::TestCase

  test "time entry validates fields" do
    timecard = Timecard.create(username: 'new time card', occurrence: Time.now)

    # play around with the fields to test presence
    entry = TimeEntry.new(time: nil, timecard: nil)
    assert !entry.valid?
    entry.timecard = timecard
    assert !entry.valid?
    entry.time = Time.now
    assert entry.valid?
    entry.timecard = nil
    assert !entry.valid?
  end

  test "time entry validates data_types" do
    timecard = Timecard.create(username: 'new time card for datatype validation', occurrence: Time.now)

    entry = TimeEntry.new(time: Time.now, timecard: timecard)
    assert entry.valid?

    entry.timecard_id = 'asdf'
    assert !entry.valid?
    entry.timecard = timecard
    assert entry.valid?

    entry.time = 'asdf'
    assert !entry.valid?
  end

  test "validates time card existence" do
    timecard = Timecard.create(username: 'another new time card', occurrence: Time.now)

    invalid_id = 34534
    assert Timecard.where(id: invalid_id).empty?
    entry = TimeEntry.new(time: Time.now, timecard_id: nil)
    assert !entry.valid?
    entry = TimeEntry.new(time: Time.now, timecard_id: timecard.id)
    assert entry.valid?
  end

  test "timecard cascade delete" do
    timecard = Timecard.create(username: 'a timecard to delete', occurrence: Time.now)
    entry = TimeEntry.create(time: Time.now, timecard_id: timecard.id)

    assert Timecard.exists?(timecard.id)
    assert TimeEntry.exists?(entry.id)

    timecard.destroy

    assert !Timecard.exists?(timecard.id)
    assert !TimeEntry.exists?(entry.id)
  end

  test "validates that time cards can have max 2 entries" do
    timecard = Timecard.create(username: 'a timecard to saturate', occurrence: Time.now)
    TimeEntry.create(timecard: timecard, time: Time.now)
    TimeEntry.create(timecard: timecard, time: Time.now)
    entry = TimeEntry.new(timecard: timecard, time: Time.now)
    assert !entry.valid?
  end

  test "adding and removing entries on a card" do
    # create a time card and add entries to it and then remove entries
    # just to see if there are any execptions caused by validations or callbacks

    timecard = Timecard.create(username: 'a timecard to use for playing with entries', occurrence: Time.now)
    entry1 = TimeEntry.create(timecard: timecard, time: Time.now)
    entry1.destroy

    entry1 = TimeEntry.create(timecard: timecard, time: Time.now)
    entry2 = TimeEntry.create(timecard: timecard, time: Time.now)
    entry2.time = Time.now
    entry1.time = Time.now + 7.hours
    entry1.save
    entry2.save
    entry1.destroy
    entry1 = TimeEntry.create(timecard: timecard, time: Time.now)
    entry2.destroy
    entry1.destroy

    # no exceptions thrown
    assert timecard.time_entries.count == 0, "there shouldnt be any entries"
  end

  # helper to get the total hours from a given timecard
  def get_total_hours(timecard)
    Timecard.where(id: timecard).pluck(:totalhours).first
  end

  # helper to transform given time period in seconds into number of hours in a format that can be compared to a stored value from the model
  def prepare_hours(time_diff)
    (time_diff/3600.0).round(TimeEntry::TOTAL_HOURS_SCALE)
  end

  test "total hours is updated" do
    # create a time card and add entries to it and then remove entries
    # at each step check total hours

    timecard = Timecard.create(username: 'a timecard that should have total hours', occurrence: Time.now)
    assert_nil get_total_hours(timecard), "There shouldnt be a total yet"

    # first entry shouldnt cause total hours to be calculated
    entry1 = TimeEntry.create(timecard: timecard, time: Time.now)
    assert_nil get_total_hours(timecard), "There shouldnt be a total yet"

    # second entry to cause calculation
    time_diff = 8.hours
    entry2 = TimeEntry.create(timecard: timecard, time: entry1.time + time_diff)
    entry2.save
    assert_equal prepare_hours(time_diff), get_total_hours(timecard), "The total hours should have been calculated"

    # update an entry to trigger new total
    time_diff = 187.minutes
    entry1.time = entry2.time - time_diff
    entry1.save
    assert_equal prepare_hours(time_diff), get_total_hours(timecard), "The total hours should have been recalculated"

    # remove an entry to clear the total
    entry1.destroy
    assert_nil get_total_hours(timecard), "total hours should have been cleared"
  end

end
