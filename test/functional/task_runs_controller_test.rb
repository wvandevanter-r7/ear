require 'test_helper'

class TaskRunsControllerTest < ActionController::TestCase
  setup do
    @task_run = task_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_run" do
    assert_difference('TaskRun.count') do
      post :create, task_run: @task_run.attributes
    end

    assert_redirected_to task_run_path(assigns(:task_run))
  end

  test "should show task_run" do
    get :show, id: @task_run.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_run.to_param
    assert_response :success
  end

  test "should update task_run" do
    put :update, id: @task_run.to_param, task_run: @task_run.attributes
    assert_redirected_to task_run_path(assigns(:task_run))
  end

  test "should destroy task_run" do
    assert_difference('TaskRun.count', -1) do
      delete :destroy, id: @task_run.to_param
    end

    assert_redirected_to task_runs_path
  end
end
