require 'test_helper'

class TimeEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_entry = time_entries(:one)
  end

  test "should get index" do
    get time_entries_url, as: :json
    assert_response :success
  end

  test "should create time_entry" do
    assert_difference('TimeEntry.count') do
      post time_entries_url, params: { time_entry: { time: @time_entry.time, timecard_id: @time_entry.timecard_id } }, as: :json
    end

    assert_response 201
  end

  test "should show time_entry" do
    get time_entry_url(@time_entry), as: :json
    assert_response :success
  end

  test "should update time_entry" do
    patch time_entry_url(@time_entry), params: { time_entry: { time: @time_entry.time, timecard_id: @time_entry.timecard_id } }, as: :json
    assert_response 200
  end

  test "should destroy time_entry" do
    assert_difference('TimeEntry.count', -1) do
      delete time_entry_url(@time_entry), as: :json
    end

    assert_response 204
  end
end
