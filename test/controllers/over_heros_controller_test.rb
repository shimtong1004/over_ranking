require 'test_helper'

class OverHerosControllerTest < ActionController::TestCase
  setup do
    @over_hero = over_heros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:over_heros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create over_hero" do
    assert_difference('OverHero.count') do
      post :create, over_hero: {  }
    end

    assert_redirected_to over_hero_path(assigns(:over_hero))
  end

  test "should show over_hero" do
    get :show, id: @over_hero
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @over_hero
    assert_response :success
  end

  test "should update over_hero" do
    patch :update, id: @over_hero, over_hero: {  }
    assert_redirected_to over_hero_path(assigns(:over_hero))
  end

  test "should destroy over_hero" do
    assert_difference('OverHero.count', -1) do
      delete :destroy, id: @over_hero
    end

    assert_redirected_to over_heros_path
  end
end
