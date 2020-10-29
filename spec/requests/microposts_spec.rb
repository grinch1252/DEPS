require "rails_helper"

RSpec.describe "Microposts", type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  let!(:micropost) { user.microposts.create( title: "test", time: 30, content: "This is test post", user_id: user.id) }
  let!(:micropost2) { other_user.microposts.create( title: "test2", time: 30, content: "This is second post", user_id: other_user.id) }

  def valid_post
    post microposts_path, params: { micropost: {title: "test", time: 30, content: "test", user_id: user.id} }
  end

  def invalid_post
    post microposts_path, params: { micropost: {title: nil, time: nil, content: nil, user_id: user.id} }
  end

  describe "create microposts" do
    it "restrict post before login" do
      expect do
        valid_post
      end.to change(Micropost, :count).by(0)
      expect(response).to redirect_to login_path
    end

    it "restrict post when submit invalid values" do
      log_in_as(user)
      get user_path(user)
      expect do
        invalid_post
      end.to change(Micropost, :count).by(0)
      expect(response).to redirect_to user_path(user)
    end

    it "succuess create post" do
      log_in_as(user)
      get user_path(user)
      expect do
        valid_post
      end.to change(Micropost, :count).by(1)
      expect(response).to redirect_to user_path(user)
    end
  end

  describe "delete microposts" do
    it "restrict destroy before login" do
      delete micropost_path(1)
      expect(response).to redirect_to login_path
    end

    it "restrict destroy as wrong user" do
      log_in_as(user)
      expect do
        delete micropost_path(micropost2)
      end.to change(Micropost, :count).by(0)
    end

    it "success destroy post" do
      log_in_as(user)
      get user_path(user)
      expect do
        delete micropost_path(micropost)
      end.to change(Micropost, :count).by(-1)
      expect(response).to redirect_to user_path(user)
    end
  end
end