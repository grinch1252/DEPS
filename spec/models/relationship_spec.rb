require "rails_helper"

RSpec.describe Relationship, type: :model do

  let!(:user) { create(:user)}
  let!(:other_user) { create(:other_user) }
  let!(:relationship) { Relationship.new(follower_id: user.id,
                                        followed_id: other_user.id) }

  describe "Relationships validation" do
    it "should be valid" do
      expect(relationship).to be_valid
    end

    it "should be exist follower_id" do
      relationship.follower_id = nil
      expect(relationship).to be_invalid
    end

    it "should be exist followed_id" do
      relationship.followed_id = nil
      expect(relationship).to be_invalid
    end
  end
end
