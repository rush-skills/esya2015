require 'test_helper'

class EventAdminsControllerTest < ActionController::TestCase
  setup do
    @event_admin = event_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_admin" do
    assert_difference('EventAdmin.count') do
      post :create, event_admin: { event_id: @event_admin.event_id, user_id: @event_admin.user_id }
    end

    assert_redirected_to event_admin_path(assigns(:event_admin))
  end

  test "should show event_admin" do
    get :show, id: @event_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_admin
    assert_response :success
  end

  test "should update event_admin" do
    patch :update, id: @event_admin, event_admin: { event_id: @event_admin.event_id, user_id: @event_admin.user_id }
    assert_redirected_to event_admin_path(assigns(:event_admin))
  end

  test "should destroy event_admin" do
    assert_difference('EventAdmin.count', -1) do
      delete :destroy, id: @event_admin
    end

    assert_redirected_to event_admins_path
  end
end
