require "rails_helper"

RSpec.describe Relationship, :type => :model do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:relationship) { Relationship.new(:follower_id => user.id,
                                        :followed_id => other_user.id) }

  context "submit valid values" do
    it "be valid" do
      expect(relationship).to be_valid
    end
  end

  describe "Relationships validation" do
    context "follower_id is nil" do
      it "be invalid" do
        relationship.follower_id = nil
        expect(relationship).to be_invalid
      end
    end

    context "followed_id is nil" do
      it "be invalid" do
        relationship.followed_id = nil
        expect(relationship).to be_invalid
      end
    end
  end
end
