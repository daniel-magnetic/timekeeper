require 'test_helper'

class TimecardTest < ActiveSupport::TestCase
  test "timecard validates presence" do
    # play around with the fields to test presence
    card = Timecard.new(username: nil, occurrence: nil)
    assert !card.valid?
    card.username = "something"
    assert !card.valid?
    card.occurrence = Time.now
    assert card.valid?
    card.username = nil
    assert !card.valid?
  end

  test "timecard validates username uniqueness" do
    # test username uniquness
    card1 = Timecard.create(username: 'somethingunique', occurrence: Time.now)
    assert Timecard.exists?(card1.id)
    card2 = Timecard.new(username: card1.username, occurrence: Time.now)
    assert !card2.valid?
  end

  test "timecard validates data_types" do
    timecard = Timecard.new(username: 'new time card for datatype validation', occurrence: Time.now)
    assert timecard.valid?

    timecard.occurrence = 'asdf'
    assert !timecard.valid?
  end

end
