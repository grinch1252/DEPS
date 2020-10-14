require "rails_helper"

RSpec.describe "Sessions", type: :request do
  include SessionsHelper
  let!(:user) { create(:user) }

  describe "get login_path" do
    it "submit invalid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
      expect(is_logged_in?).to be_falsey
    end

    it "submit valid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(flash[:danger]).to be_falsey
      expect(is_logged_in?).to be_truthy
    end

    it "login and logout" do
      get login_path
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
    end

    it "can't logout twice" do
      log_in_as(user)
      expect(is_logged_in?).to be_truthy
      expect(response).to redirect_to user_path(user)
      delete logout_path
      expect(is_logged_in?).to be_falsey
      expect(response).to redirect_to root_path
      delete logout_path
      expect(response).to redirect_to root_path
    end

    it "checked remember_me-box" do
      log_in_as(user, remember_me = 1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be nil
    end

    it "didn't check remember_me-box" do
      log_in_as(user, remember_me = 0)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).to be nil
    end

    it "does't have remember_token after logout" do
      log_in_as(user, remember_me = 1)
      expect(is_logged_in?).to be_truthy
      expect(cookies[:remember_token]).not_to be_empty
      delete logout_path
      expect(is_logged_in?).to be_falsey
      expect(cookies[:remember_token]).to be_empty
    end
  end
end
