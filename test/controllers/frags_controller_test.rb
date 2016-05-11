require 'test_helper'

class FragsControllerTest < ActionController::TestCase
  setup do
    @frag = frags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frag" do
    assert_difference('Frag.count') do
      post :create, frag: {  }
    end

    assert_redirected_to frag_path(assigns(:frag))
  end

  test "should show frag" do
    get :show, id: @frag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frag
    assert_response :success
  end

  test "should update frag" do
    patch :update, id: @frag, frag: {  }
    assert_redirected_to frag_path(assigns(:frag))
  end

  test "should destroy frag" do
    assert_difference('Frag.count', -1) do
      delete :destroy, id: @frag
    end

    assert_redirected_to frags_path
  end
end
