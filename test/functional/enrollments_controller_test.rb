require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  setup do
    @enrollment = Factory(:enrollment)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enrollments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show enrollment" do
    get :show, :id => @enrollment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @enrollment.to_param
    assert_response :success
  end

  test "should update enrollment" do
    put :update, :id => @enrollment.to_param, :enrollment => @enrollment.attributes
    assert_redirected_to enrollment_path(assigns(:enrollment))
  end

  test "should destroy enrollment" do
    assert_difference('Enrollment.count', -1) do
      delete :destroy, :id => @enrollment.to_param
    end

    assert_redirected_to enrollments_path
  end
end
