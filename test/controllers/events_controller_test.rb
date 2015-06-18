require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { contact: @event.contact, eligibilty: @event.eligibilty, event_date_time: @event.event_date_time, judging: @event.judging, name: @event.name, photo: @event.photo, prizes: @event.prizes, registration_deadline: @event.registration_deadline, rules: @event.rules, team_size: @event.team_size, type: @event.type, venue: @event.venue }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { contact: @event.contact, eligibilty: @event.eligibilty, event_date_time: @event.event_date_time, judging: @event.judging, name: @event.name, photo: @event.photo, prizes: @event.prizes, registration_deadline: @event.registration_deadline, rules: @event.rules, team_size: @event.team_size, type: @event.type, venue: @event.venue }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
