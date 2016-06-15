require 'test_helper'

class OverProfilesControllerTest < ActionController::TestCase
  setup do
    @over_profile = over_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:over_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create over_profile" do
    assert_difference('OverProfile.count') do
      post :create, over_profile: {  }
    end

    assert_redirected_to over_profile_path(assigns(:over_profile))
  end

  test "should show over_profile" do
    get :show, id: @over_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @over_profile
    assert_response :success
  end

  test "should update over_profile" do
    patch :update, id: @over_profile, over_profile: {  }
    assert_redirected_to over_profile_path(assigns(:over_profile))
  end

  test "should destroy over_profile" do
    assert_difference('OverProfile.count', -1) do
      delete :destroy, id: @over_profile
    end

    assert_redirected_to over_profiles_path
  end
end
