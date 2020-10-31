require "rails_helper"

RSpec.describe Like, type: :request do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:micropost) { user.microposts.create( time: 240,
                                            title: "Test",
                                            content: "Test Post") }

  describe "#create" do
    context "before login" do
      it "fail to create" do
        expect do
          post likes_path
        end.to change(Like, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end
    context "as correct user" do
      it "succeed create" do
        log_in_as(other_user)
        expect do
          post likes_path, params: { micropost_id: micropost.id }
        end.to change(Like, :count).by(1)
      end
    end
  end

  describe "#destroy" do
    context "before login" do
      it "fail to destroy" do
        like = micropost.like(other_user)
        expect do
          delete like_path(like)
        end.to change(Like, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end

    context "as correct user" do
      it "succeed destroy" do
        log_in_as(other_user)
        like = micropost.like(other_user)
        expect do
          delete like_path(like)
        end.to change(Like, :count).by(-1)
      end
    end
  end
end