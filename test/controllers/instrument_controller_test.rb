require "test_helper"

class InstrumentControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get instrument_name:string_url
    assert_response :success
  end

  test "should get nickname:string" do
    get instrument_nickname:string_url
    assert_response :success
  end

  test "should get nfs_path:string" do
    get instrument_nfs_path:string_url
    assert_response :success
  end

  test "should get platform:integer" do
    get instrument_platform:integer_url
    assert_response :success
  end
end
