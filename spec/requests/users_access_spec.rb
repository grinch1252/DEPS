require "rails_helper"

RSpec.describe "Users", :type => :request do

  let!(:user) { create(:user) }
  let!(:no_activated_user) { create(:no_activated_user) }

  describe "#create user" do
    context "submit valid values" do
      it "submit valid values" do
        get signup_path
        expect(response).to have_http_status(:success)
        expect {
          post signup_path, :params => {
            :user => {
              :name => "testuser",
              :email => "example@valid.com",
              :password => "testuser",
              :password_confirmation => "testuser"
            }
          }
        }.to change(User, :count).by(1)
      end
    end

    context "submit invalid values" do
      it "fail to create" do
        get signup_path
        expect(response).to have_http_status(:success)
        expect {
          post signup_path, :params => {
            :user => {
              :name => "",
              :email => "example@in-va-lid.com..",
              :password => "test",
              :password_confirmation => "foo"
            }
          }
        }.not_to change(User, :count)
      end
    end

  end

  describe "#show user" do
    context "before login" do
      it "fail to access to user page" do
        get user_path(user)
        expect(response).to redirect_to login_path
      end

      it "fali to access to following" do
        get following_user_path(user)
        expect(response).to redirect_to login_path
      end

      it "fail to access to followers" do
        get followers_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "before activation" do
      it "fail to access user page" do
        get login_path
        log_in_as(no_activated_user)
        expect(flash[:danger]).to be_truthy
        expect(is_logged_in?).to be_falsey
        expect(response).to redirect_to root_path
      end
    end
  end
end
