require("rails_helper")

RSpec.describe Relationship, type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe "#create" do
    context "before login" do
      it "fail to create" do
        expect do
          post relationships_path
        end.to change(Relationship, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end

    context "as correct user" do
      it "succeed create" do
        log_in_as(user)
        expect do
          post relationships_path, xhr: true, params: { followed_id: other_user.id }
        end.to change(user.following, :count).by(1)
      end
    end
  end

  describe "#destroy" do
    context "as correct user" do
      it "succeed cestroy" do
        log_in_as(user)
        user.follow(other_user)
        relationship = user.active_relationships.find_by(followed_id: other_user.id)
        expect do
          delete relationship_path(relationship), xhr: true
        end.to change(user.following, :count).by(-1)
      end
    end

    context "before login" do
      it "fail to destroy" do
        relationship = Relationship.new(  id: 100,
                                          follower_id: user.id,
                                          followed_id: other_user.id)
        expect do
          delete relationship_path(relationship)
        end.to change(Relationship, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end
  end
end