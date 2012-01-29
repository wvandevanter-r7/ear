require 'test_helper'

class NetBlocksControllerTest < ActionController::TestCase
  setup do
    @net_block = net_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:net_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create net_block" do
    assert_difference('NetBlock.count') do
      post :create, net_block: @net_block.attributes
    end

    assert_redirected_to net_block_path(assigns(:net_block))
  end

  test "should show net_block" do
    get :show, id: @net_block.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @net_block.to_param
    assert_response :success
  end

  test "should update net_block" do
    put :update, id: @net_block.to_param, net_block: @net_block.attributes
    assert_redirected_to net_block_path(assigns(:net_block))
  end

  test "should destroy net_block" do
    assert_difference('NetBlock.count', -1) do
      delete :destroy, id: @net_block.to_param
    end

    assert_redirected_to net_blocks_path
  end
end
