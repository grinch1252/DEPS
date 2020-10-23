require "rails_helper"

RSpec.describe "Events", type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  let!(:event) { user.events.create( title: "test", start: Time.zone.now, body: "This is test event", user_id: user.id) }
  let!(:event2) { other_user.events.create( title: "test2", start: Time.zone.now, body: "This is second event", user_id: other_user.id) }

  def valid_event
    post events_path, params: { event: {title: "test", start: Time.zone.now, body: "test", user_id: user.id} }
  end

  def invalid_event
    post events_path, params: { event: {title: nil, start: nil, body: nil, user_id: user.id} }
  end

  describe "create events" do
    it "restrict create event before login" do
      expect do
        valid_event
      end.to change(Event, :count).by(0)
      expect(response).to redirect_to login_path
    end

    it "restrict create event when submit invalid values" do
      log_in_as(user)
      get user_path(user)
      expect do
        invalid_event
      end.to change(Event, :count).by(0)
      expect(response).to redirect_to user_path(user)
    end

    it "succuess create event" do
      log_in_as(user)
      get user_path(user)
      expect do
        valid_event
      end.to change(Event, :count).by(1)
      expect(response).to redirect_to events_path
    end
  end

  describe "delete events" do
    it "restrict destroy event before login" do
      delete event_path(1)
      expect(response).to redirect_to login_path
    end

    it "restrict destroy event as wrong user" do
      log_in_as(user)
      expect do
        delete event_path(event2)
      end.to change(Event, :count).by(0)
    end

    it "success destroy event" do
      log_in_as(user)
      get user_path(user)
      expect do
        delete event_path(event)
      end.to change(Event, :count).by(-1)
      expect(response).to redirect_to events_path
      expect(flash[:success]).to be_truthy
    end
  end

end