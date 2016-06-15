require 'test_helper'

class OverPlatformsControllerTest < ActionController::TestCase
  setup do
    @over_platform = over_platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:over_platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create over_platform" do
    assert_difference('OverPlatform.count') do
      post :create, over_platform: {  }
    end

    assert_redirected_to over_platform_path(assigns(:over_platform))
  end

  test "should show over_platform" do
    get :show, id: @over_platform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @over_platform
    assert_response :success
  end

  test "should update over_platform" do
    patch :update, id: @over_platform, over_platform: {  }
    assert_redirected_to over_platform_path(assigns(:over_platform))
  end

  test "should destroy over_platform" do
    assert_difference('OverPlatform.count', -1) do
      delete :destroy, id: @over_platform
    end

    assert_redirected_to over_platforms_path
  end
end
