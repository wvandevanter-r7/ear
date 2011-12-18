require 'test_helper'

class ObjectMappingsControllerTest < ActionController::TestCase
  setup do
    @object_mapping = object_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:object_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create object_mapping" do
    assert_difference('ObjectMapping.count') do
      post :create, object_mapping: @object_mapping.attributes
    end

    assert_redirected_to object_mapping_path(assigns(:object_mapping))
  end

  test "should show object_mapping" do
    get :show, id: @object_mapping.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @object_mapping.to_param
    assert_response :success
  end

  test "should update object_mapping" do
    put :update, id: @object_mapping.to_param, object_mapping: @object_mapping.attributes
    assert_redirected_to object_mapping_path(assigns(:object_mapping))
  end

  test "should destroy object_mapping" do
    assert_difference('ObjectMapping.count', -1) do
      delete :destroy, id: @object_mapping.to_param
    end

    assert_redirected_to object_mappings_path
  end
end
