require 'test_helper'

class OverAchievementsControllerTest < ActionController::TestCase
  setup do
    @over_achievement = over_achievements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:over_achievements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create over_achievement" do
    assert_difference('OverAchievement.count') do
      post :create, over_achievement: {  }
    end

    assert_redirected_to over_achievement_path(assigns(:over_achievement))
  end

  test "should show over_achievement" do
    get :show, id: @over_achievement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @over_achievement
    assert_response :success
  end

  test "should update over_achievement" do
    patch :update, id: @over_achievement, over_achievement: {  }
    assert_redirected_to over_achievement_path(assigns(:over_achievement))
  end

  test "should destroy over_achievement" do
    assert_difference('OverAchievement.count', -1) do
      delete :destroy, id: @over_achievement
    end

    assert_redirected_to over_achievements_path
  end
end
