require 'test_helper'

class PhysicalLocationsControllerTest < ActionController::TestCase
  setup do
    @physical_location = physical_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:physical_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create physical_location" do
    assert_difference('PhysicalLocation.count') do
      post :create, physical_location: @physical_location.attributes
    end

    assert_redirected_to physical_location_path(assigns(:physical_location))
  end

  test "should show physical_location" do
    get :show, id: @physical_location.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @physical_location.to_param
    assert_response :success
  end

  test "should update physical_location" do
    put :update, id: @physical_location.to_param, physical_location: @physical_location.attributes
    assert_redirected_to physical_location_path(assigns(:physical_location))
  end

  test "should destroy physical_location" do
    assert_difference('PhysicalLocation.count', -1) do
      delete :destroy, id: @physical_location.to_param
    end

    assert_redirected_to physical_locations_path
  end
end
