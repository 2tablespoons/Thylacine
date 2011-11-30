require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get process" do
    get :process
    assert_response :success
  end

  test "should get thanks" do
    get :thanks
    assert_response :success
  end

end
