require 'test_helper'

class TimecardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timecard = timecards(:one)
    @timecard_new_unique = Timecard.new(occurrence: Time.now, username: 'somethingthatshouldntbehere')
  end

  test "should get index" do
    get timecards_url, as: :json
    assert_response :success

    response_json = response.parsed_body
    assert_equal 2, response_json.count, "the response should have 2 cards"

    expected_fields = %w(id totalhours username occurrence time_entries)
    assert_equal expected_fields, expected_fields & response_json.first.keys, 'The response should contain the expected fields'

    expected_sub_fields = %w(id time timecard_id)
    assert_equal expected_sub_fields , expected_sub_fields & response_json.first['time_entries'].first.keys, 'The response sub entries should contain the expected fields'
  end

  test "should create timecard" do
    assert_difference('Timecard.count') do
      post timecards_url, params: { timecard: { occurrence: @timecard_new_unique.occurrence, username: @timecard_new_unique.username } }, as: :json
    end

    assert_response 201
  end

  test "should not_create non_unique_timecard" do
    assert_no_difference('Timecard.count') do
      post timecards_url, params: { timecard: { occurrence: @timecard.occurrence, username: @timecard.username } }, as: :json
    end

    assert_response 422
  end

  test "should not_create dataless_timecard" do
    assert_no_difference('Timecard.count') do
      post timecards_url, params: { }, as: :json
    end

    assert_response 422
  end

  test "should not_create invalid_timecard" do
    assert_no_difference('Timecard.count') do
      post timecards_url, params: { timecard: {occurrence: nil, username: nil} }, as: :json
    end

    assert_response 422
  end

  test "should show timecard" do
    get timecard_url(@timecard), as: :json
    assert_response :success

    response_json = response.parsed_body
    expected_fields = %w(id totalhours username occurrence)
    assert_equal expected_fields, expected_fields & response_json.keys, 'The response should contain the expected fields'

    assert_equal @timecard.username, response_json["username"], 'The name should be present'
    assert_equal @timecard.occurrence, response_json["occurrence"], 'The occurrence should be present'
  end

  test "should update timecard" do
    patch timecard_url(@timecard), params: { timecard: { occurrence: @timecard.occurrence, username: @timecard.username } }, as: :json
    assert_response 200
  end

  test "should not_update non_present_timecard" do
    patch timecard_url(@timecard), params: { timecard: { occurrence: nil, username: "" } }, as: :json
    assert_response 422
  end

  # make sure the user cant manually update the total hours cache field
  test "should not_update_hours timecard" do
    assert_no_difference(@timecard.totalhours) do
      patch timecard_url(@timecard), params: { timecard: { totalhours: 20 } }, as: :json
    end
    assert_response 200
  end

  test "should destroy timecard" do
    assert_difference('Timecard.count', -1) do
      delete timecard_url(@timecard), as: :json
    end

    assert_response 204
  end
end
