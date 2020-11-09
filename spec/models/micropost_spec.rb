require "rails_helper"

RSpec.describe Micropost, type: :model do

  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(time: 240,
                                          title: "Test",
                                          content: "Test Post",
                                          user_id: user.id) }

  context "submit valid values" do
    it "be valid" do
      expect(micropost).to be_valid
    end
  end

  describe "Micropost validation" do
    context "user_id is nil" do
      it "be invalid" do
        micropost.user_id = nil
        expect(micropost).to be_invalid
      end
    end

    context "title is nil" do
      it "be invalid" do
        micropost.title = nil
        expect(micropost).to be_invalid
      end
    end

    context "title is too long" do
      it "be invalid" do
        micropost.title = "A" * 26
        expect(micropost).to be_invalid
      end
    end

    context "content is nil" do
      it "be invalid" do
        micropost.content = nil
        expect(micropost).to be_invalid
      end
    end

    context "content is too long" do
      it "be invalid" do
        micropost.content = "A" * 256
        expect(micropost).to be_invalid
      end
    end

    context "time is lower than 0" do
      it "be invalid" do
        micropost.time = -5
        expect(micropost).to be_invalid
      end
    end

    context "all is nil except for user_id" do
      it "be invalid" do
        micropost.update( time: nil,
                          title: nil,
                          content: nil,
                          user_id: user.id)
        expect(micropost).to be_invalid
      end
    end
  end

  describe "micropost order" do
    it "should be most recent first" do
      create(:microposts, :post_1, created_at: 10.minutes.ago, user_id: user.id)
      create(:microposts, :post_2, created_at: 3.years.ago, user_id: user.id)
      create(:microposts, :post_3, created_at: 2.hours.ago, user_id: user.id)
      post_4 = create(:microposts, :post_4, created_at: Time.zone.now, user_id: user.id)
      expect(post_4).to eq Micropost.first
    end
  end

  describe "dependancy of micropost" do
    context "user deleted" do
      it "destroy micropost" do
        user.microposts.create!(content: "Lorem Ipsum", user_id: user.id, time: 100, title: "Lorem")
        expect{ user.destroy }.to change{ Micropost.count }.by(-1)
      end
    end
  end
end
