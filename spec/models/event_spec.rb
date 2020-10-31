require 'rails_helper'

RSpec.describe Event, type: :model do

  let!(:user) { create(:user) }
  let!(:event) { user.events.build( start:"2020-09-27T00:00:00+09:00",
                                    end:"2020-11-08T00:00:00+09:00",
                                    title: "Test",
                                    body: "Test Event",
                                    user_id: user.id) }

  context "submit valid values" do
    it "be valid" do
      expect(event).to be_valid
    end
  end

  describe "Event validation" do
    context "user_id is nil" do
      it "be invalid" do
        event.user_id = nil
        expect(event).to be_invalid
      end
    end

    context "title is too long" do
      it "be invalid" do
        event.title = "A" * 26
        expect(event).to be_invalid
      end
    end

    context "content is too long" do
      it "be invalid" do
        event.body = "A" * 256
        expect(event).to be_invalid
      end
    end

    context "all is nil except for user_id" do
      it "be invalid" do
        event.update_attributes(start: nil,
                                end: nil,
                                title: nil,
                                body: nil,
                                user_id: user.id)
        expect(event).to be_invalid
      end
    end
  end

  describe "event order" do
    it "should be most recent first" do
      create(:events, :event_1, start: Time.zone.now.since(10.minutes), user_id: user.id)
      create(:events, :event_2, start: Time.zone.now.since(30.minutes), user_id: user.id)
      create(:events, :event_3, start: Time.zone.now.since(3.years), user_id: user.id)
      event_4 = create(:events, :event_4, start: Time.zone.now, user_id: user.id)
      expect(event_4).to eq Event.first
    end
  end

  describe "dependancy of event" do
    context "user deleted" do
      it "destroy event" do
        user.events.create!(title: "Lorem",
                            body: "Lorem Ipsum",
                            start: Time.zone.now,
                            user_id: user.id)
        expect{ user.destroy }.to change{ Event.count }.by(-1)
      end
    end
  end
end
