require 'test_helper'

class ApkBinsControllerTest < ActionController::TestCase
  setup do
    @apk_bin = apk_bins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apk_bins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apk_bin" do
    assert_difference('ApkBin.count') do
      post :create, apk_bin: @apk_bin.attributes
    end

    assert_redirected_to apk_bin_path(assigns(:apk_bin))
  end

  test "should show apk_bin" do
    get :show, id: @apk_bin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @apk_bin
    assert_response :success
  end

  test "should update apk_bin" do
    put :update, id: @apk_bin, apk_bin: @apk_bin.attributes
    assert_redirected_to apk_bin_path(assigns(:apk_bin))
  end

  test "should destroy apk_bin" do
    assert_difference('ApkBin.count', -1) do
      delete :destroy, id: @apk_bin
    end

    assert_redirected_to apk_bins_path
  end
end
