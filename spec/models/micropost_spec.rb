require "rails_helper"

RSpec.describe Micropost, type: :model do

  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(time: 240, title: "Test", content: "Test Post", user_id: user.id) }

  describe "Micropost validation" do
    it "should be valid" do
      expect(micropost).to be_valid
    end

    it "should be invalid when user_id is nil" do
      micropost.user_id = nil
      expect(micropost).to be_invalid
    end

    it "should be invalid when length of title over 25" do
      micropost.title = "A" * 26
      expect(micropost).to be_invalid
    end

    it "should be invalid when length of content over 255" do
      micropost.content = "A" * 256
      expect(micropost).to be_invalid
    end

    it "should be invalid when time, title and content are nil" do
      micropost.update_attributes(time: nil, title: nil, content: nil, user_id: user.id)
      expect(micropost).to be_invalid
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
    it "destroy micropost when user deleted" do
      user.microposts.create!(content: "Lorem Ipsum", user_id: user.id)
      expect{ user.destroy }.to change{ Micropost.count }.by(-1)
    end
  end
end
