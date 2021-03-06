require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase
  setup do
    @exercise = exercises(:one)
    @exercise.etitle = 'unique etitle'
  end

  test "should get index" do
    sign_in users(:user1)
    get :index
    assert_response :success
    assert_not_nil assigns(:exercises)
  end

  test "should get new" do
    sign_in users(:user1)
    get :new
    assert_response :success
  end

  test "should create exercise" do
    sign_in users(:user1)
    assert_difference('Exercise.count') do
      post :create, :exercise => @exercise.attributes
    end

    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should show exercise" do
    get :show, :id => @exercise.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:user1)
    get :edit, :id => @exercise.to_param
    assert_response :success
  end

  test "should update exercise" do
    sign_in users(:user1)
    put :update, :id => @exercise.to_param, :exercise => @exercise.attributes
    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should destroy exercise" do
    sign_in users(:user1)
    assert_difference('Exercise.count', -1) do
      delete :destroy, :id => @exercise.to_param
    end

    assert_redirected_to exercises_path
  end
end
