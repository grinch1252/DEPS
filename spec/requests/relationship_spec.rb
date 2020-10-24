require("rails_helper")

RSpec.describe Relationship, type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe "require login" do
    it "create relationship" do
      expect do
        post relationships_path
      end.to change(Relationship, :count).by(0)
      expect(response).to redirect_to login_path
    end

    it "destroy relationship" do
      relationship = Relationship.new(  id: 100,
                                        follower_id: user.id,
                                        followed_id: other_user.id)
      expect do
        delete relationship_path(relationship)
      end.to change(Relationship, :count).by(0)
      expect(response).to redirect_to login_path
    end
  end

  describe "follow and unfollow" do

    before do
      log_in_as(user)
    end

    it "follow with standard way" do
      expect do
        post relationships_path, params: { followed_id: other_user.id }
      end.to change(user.following, :count).by(1)
    end

    it "follow with Ajax" do
      expect do
        post relationships_path, xhr: true, params: { followed_id: other_user.id }
      end.to change(user.following, :count).by(1)
    end

    it "unfollow with standard way" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship)
      end.to change(user.following, :count).by(-1)
    end

    it "unfollow with Ajax" do
      user.follow(other_user)
      relationship = user.active_relationships.find_by(followed_id: other_user.id)
      expect do
        delete relationship_path(relationship), xhr: true
      end.to change(user.following, :count).by(-1)
    end
  end
end