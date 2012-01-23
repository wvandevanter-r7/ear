require 'test_helper'

class NetSvcsControllerTest < ActionController::TestCase
  setup do
    @net_svc = net_svcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:net_svcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create net_svc" do
    assert_difference('NetSvc.count') do
      post :create, net_svc: @net_svc.attributes
    end

    assert_redirected_to net_svc_path(assigns(:net_svc))
  end

  test "should show net_svc" do
    get :show, id: @net_svc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @net_svc.to_param
    assert_response :success
  end

  test "should update net_svc" do
    put :update, id: @net_svc.to_param, net_svc: @net_svc.attributes
    assert_redirected_to net_svc_path(assigns(:net_svc))
  end

  test "should destroy net_svc" do
    assert_difference('NetSvc.count', -1) do
      delete :destroy, id: @net_svc.to_param
    end

    assert_redirected_to net_svcs_path
  end
end
