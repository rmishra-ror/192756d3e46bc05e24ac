require 'test_helper'

class Api::RobotControllerTest < ActionDispatch::IntegrationTest
  test "valid respose" do
  	post "/api/robot/0/orders", params: { commands: [ "PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT" ] }
    assert_response :success
   	assert_equal({"location"=>[3, 3, "NORTH"]}, response.parsed_body)
  end

  test "Invalid respose" do
  	post "/api/robot/0/orders", params: { commands: [ "PLACE 5,5,EASTAA", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT" ] }
    assert_equal 400, status
   	assert_equal({"mesage"=>"command params is wrong"}, response.parsed_body)
  end

end
