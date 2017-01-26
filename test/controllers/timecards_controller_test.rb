require 'test_helper'

class TimecardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timecard = timecards(:one)
  end

  test "should get index" do
    get timecards_url, as: :json
    assert_response :success
  end

  test "should create timecard" do
    assert_difference('Timecard.count') do
      post timecards_url, params: { timecard: { occurrence: @timecard.occurrence, username: @timecard.username } }, as: :json
    end

    assert_response 201
  end

  test "should show timecard" do
    get timecard_url(@timecard), as: :json
    assert_response :success
  end

  test "should update timecard" do
    patch timecard_url(@timecard), params: { timecard: { occurrence: @timecard.occurrence, username: @timecard.username } }, as: :json
    assert_response 200
  end

  test "should destroy timecard" do
    assert_difference('Timecard.count', -1) do
      delete timecard_url(@timecard), as: :json
    end

    assert_response 204
  end
end
