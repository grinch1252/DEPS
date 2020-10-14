require "rails_helper"

RSpec.describe "PasswordResets", type: :request do

  let!(:user) { create(:user) }

  describe "password reset" do
    it "valid email address" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(flash[:info]).to be_truthy
      expect(response).to redirect_to root_path
    end

    it "invalid email address" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: "" } }
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to new_password_reset_path
    end
  end

  describe "edit password" do
    it "invalid email address" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: "")
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to new_password_reset_path
    end

    it "invalid user" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to new_password_reset_path
    end

    it "invalid token" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      user = assigns(:user)
      get edit_password_reset_path("wrong token", email: user.email)
      expect(flash[:danger]).to be_truthy
      expect(response).to redirect_to new_password_reset_path
    end

    it "valid values" do
      get new_password_reset_path
      post password_resets_path, params: { password_reset: { email: user.email } }
      expect(flash[:danger]).to be_falsey
      expect(response).to redirect_to root_path
      user = assigns(:user)
      get edit_password_reset_path(user.reset_token, email: user.email)
    end
  end
end
