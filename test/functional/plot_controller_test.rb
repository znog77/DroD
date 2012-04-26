require 'test_helper'

class PlotControllerTest < ActionController::TestCase
  test "should get sqm" do
    get :sqm
    assert_response :success
  end

end
