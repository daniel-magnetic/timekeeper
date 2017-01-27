require 'test_helper'

class TimeEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_entry = time_entries(:one)
  end

  test "should get index" do
    get time_entries_url, as: :json
    assert_response :success

    response_json = response.parsed_body
    assert_equal 2, response_json.count, "the response should have the correct number of entries"

    expected_fields = %w(time timecard_id)
    assert_equal expected_fields, expected_fields & response_json.first.keys, 'The response should contain the expected fields'
  end

  test "should create time_entry" do
    assert_difference('TimeEntry.count') do
      post time_entries_url, params: { time_entry: { time: @time_entry.time, timecard_id: @time_entry.timecard_id } }, as: :json
    end

    assert_response 201
  end

  # when the post data is empty
  test "should not_create empty_time_entry" do
    assert_no_difference('TimeEntry.count') do
      post time_entries_url, params: { time_entry: { } }, as: :json
    end

    assert_response 422
  end

  # when the post data doesnt contain the right data
  test "should not_create non_present_time_entry" do
    assert_no_difference('TimeEntry.count') do
      post time_entries_url, params: { time_entry: { someunusedparam: 'a'} }, as: :json
    end

    assert_response 422
  end

  test "should show time_entry" do
    get time_entry_url(@time_entry), as: :json
    assert_response :success

    response_json = response.parsed_body
    expected_fields = %w(time timecard_id)
    assert_equal expected_fields, expected_fields & response_json.keys, 'The response should contain the expected fields'

    assert_equal @time_entry.timecard_id, response_json["timecard_id"], 'The timecard id should be present'
    assert_equal @time_entry.time, response_json["time"], 'The time should be present'

  end

  test "should update time_entry" do
    patch time_entry_url(@time_entry), params: { time_entry: { time: @time_entry.time, timecard_id: @time_entry.timecard_id } }, as: :json
    assert_response 200
  end

  test "should notupdate_invalid time_entry" do
    patch time_entry_url(@time_entry), params: { time_entry: { time: nil  } }, as: :json
    assert_response 422
  end

  test "should destroy time_entry" do
    assert_difference('TimeEntry.count', -1) do
      delete time_entry_url(@time_entry), as: :json
    end

    assert_response 204
  end
end
