require "rails_helper"

RSpec.describe Like, :type => :model do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  let!(:micropost) { user.microposts.create( :time => 240,
                                            :title => "Test",
                                            :content => "Test Post") }
  let!(:like) { micropost.like(other_user) }

  context "submit valid values" do
    it "be valid" do
      expect(like).to be_valid
    end
  end

  describe "Like validation" do
    context "user_id is nil" do
      it "be invalid" do
        like.user_id = nil
        expect(like.valid?).to be_falsey
      end
    end

    context "micropost_id is nil" do
      it "be invalid" do
        like.micropost_id = nil
        expect(like.valid?).to be_falsey
      end
    end
  end
end
