require "rails_helper"

RSpec.describe "Sessions", :type => :request do
  include SessionsHelper
  let!(:user) { create(:user) }

  describe "#get login_path" do
    context "submit valid values" do
      it "submit valid values" do
        get login_path
        expect(response).to have_http_status(:success)
        post login_path, :params => {
          :session => { :email => user.email,
                        :password => user.password
          } }
        expect(flash[:danger]).to be_falsey
        expect(is_logged_in?).to be_truthy
      end
    end

    context "submit invalid values" do
      it "fail to get" do
        get login_path
        expect(response).to have_http_status(:success)
        post login_path, :params => {
          :session => { :email => "",
                        :password => ""
          } }
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
      end
    end
  end

  describe "login and logout" do
    it "succeed login and logout" do
      get login_path
      post login_path, :params => {
        :session => { :email => user.email,
                      :password => user.password
        } }
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
    end

    context "logout twice" do
      it "fail to logout" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        expect(response).to redirect_to user_path(user)
        delete logout_path
        expect(is_logged_in?).to be_falsey
        expect(response).to redirect_to root_path
        delete logout_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "Remember me" do
    context "checked remember_me box" do
      it "remember_token exists" do
        log_in_as(user, remember_me = 1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be nil
      end
    end

    context "didn't check remember_me box" do
      it "remember_token is nil" do
        log_in_as(user, remember_me = 0)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).to be nil
      end
    end

    context "after logout" do
      it "remember_token is empty" do
        log_in_as(user, remember_me = 1)
        expect(is_logged_in?).to be_truthy
        expect(cookies[:remember_token]).not_to be_empty
        delete logout_path
        expect(is_logged_in?).to be_falsey
        expect(cookies[:remember_token]).to be_empty
      end
    end
  end
end
