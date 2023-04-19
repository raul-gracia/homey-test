require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_new_url
    assert_response :success
  end

  test "should get roll" do
    get game_roll_url
    assert_response :success
  end

  test "should get cash-out" do
    get game_cash-out_url
    assert_response :success
  end

  test "should get game" do
    get game_game_url
    assert_response :success
  end
end
