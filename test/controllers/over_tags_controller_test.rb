require 'test_helper'

class OverTagsControllerTest < ActionController::TestCase
  setup do
    @over_tag = over_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:over_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create over_tag" do
    assert_difference('OverTag.count') do
      post :create, over_tag: {  }
    end

    assert_redirected_to over_tag_path(assigns(:over_tag))
  end

  test "should show over_tag" do
    get :show, id: @over_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @over_tag
    assert_response :success
  end

  test "should update over_tag" do
    patch :update, id: @over_tag, over_tag: {  }
    assert_redirected_to over_tag_path(assigns(:over_tag))
  end

  test "should destroy over_tag" do
    assert_difference('OverTag.count', -1) do
      delete :destroy, id: @over_tag
    end

    assert_redirected_to over_tags_path
  end
end
