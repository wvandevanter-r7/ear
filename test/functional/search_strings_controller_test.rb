require 'test_helper'

class SearchStringsControllerTest < ActionController::TestCase
  setup do
    @search_string = search_strings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_strings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_string" do
    assert_difference('SearchString.count') do
      post :create, search_string: @search_string.attributes
    end

    assert_redirected_to search_string_path(assigns(:search_string))
  end

  test "should show search_string" do
    get :show, id: @search_string.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @search_string.to_param
    assert_response :success
  end

  test "should update search_string" do
    put :update, id: @search_string.to_param, search_string: @search_string.attributes
    assert_redirected_to search_string_path(assigns(:search_string))
  end

  test "should destroy search_string" do
    assert_difference('SearchString.count', -1) do
      delete :destroy, id: @search_string.to_param
    end

    assert_redirected_to search_strings_path
  end
end
