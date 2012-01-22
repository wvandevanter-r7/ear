require 'test_helper'

class WebFormsControllerTest < ActionController::TestCase
  setup do
    @web_form = web_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:web_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create web_form" do
    assert_difference('WebForm.count') do
      post :create, web_form: @web_form.attributes
    end

    assert_redirected_to web_form_path(assigns(:web_form))
  end

  test "should show web_form" do
    get :show, id: @web_form.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @web_form.to_param
    assert_response :success
  end

  test "should update web_form" do
    put :update, id: @web_form.to_param, web_form: @web_form.attributes
    assert_redirected_to web_form_path(assigns(:web_form))
  end

  test "should destroy web_form" do
    assert_difference('WebForm.count', -1) do
      delete :destroy, id: @web_form.to_param
    end

    assert_redirected_to web_forms_path
  end
end
