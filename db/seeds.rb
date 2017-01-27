# some arbitrary data to make demoing this app easier
timecard = Timecard.create(username: 'daniel', occurrence: Time.now)
timecard.save
timecard.time_entries.create(time: Time.now - 7.hours)
timecard.time_entries.create(time: Time.now - 4.hours - 28.minutes)
timecard.save

timecard = Timecard.create(username: 'pamela', occurrence: Time.now)
timecard.save
timecard.time_entries.create(time: Time.now - 7.hours)
timecard.save

timecard = Timecard.create(username: 'rohan', occurrence: Time.now)
