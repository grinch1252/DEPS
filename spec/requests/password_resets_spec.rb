require "rails_helper"

RSpec.describe "PasswordResets", :type => :request do

  let!(:user) { create(:user) }

  describe "password reset" do
    context "valid values" do
      it "secceed accept reset mail" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        expect(flash[:info]).to be_truthy
        expect(response).to redirect_to root_path
      end
    end

    context "invalid values" do
      it "fail to accept reset mail" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => "" } }
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end
  end

  describe "GET edit_password_resets" do
    context "valid values" do
      it "succeed get" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        expect(flash[:danger]).to be_falsey
        expect(response).to redirect_to root_path
        user = assigns(:user)
        get edit_password_reset_path(user.reset_token, :email => user.email)
      end
    end

    context "email is invalid" do
      it "fail to get" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        get edit_password_reset_path(user.reset_token, :email => "")
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end

    context "user is invalid" do
      it "fail to get" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        user.toggle!(:activated)
        get edit_password_reset_path(user.reset_token, :email => user.email)
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end

    context "token is invalid" do
      it "fail to get" do
        get new_password_reset_path
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        get edit_password_reset_path("wrong token", :email => user.email)
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to new_password_reset_path
      end
    end
  end

  describe "#PATCH edit_password_resets" do
    context "valid values" do
      it "succeed patch" do
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        get edit_password_reset_path(user.reset_token, :email => user.email)
        patch password_reset_path(user.reset_token), :params => { :email => user.email,
                                                                  :user => {
                                                                    :password => "testuser",
                                                                    :password_confirmation => "testuser"
                                                                  } }
        expect(response).to redirect_to user_path(user)
      end
    end

    context "password is invalid" do
      it "fail to patch" do
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        get edit_password_reset_path(user.reset_token, :email => user.email)
        patch password_reset_path(user.reset_token), :params => { :email => user.email,
                                                                  :user => {
                                                                    :password => "foobar",
                                                                    :password_confirmation => "bazfoo"
                                                                  } }
        expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
      end
    end

    context "password is empty" do
      it "fail to patch" do
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        get edit_password_reset_path(user.reset_token, :email => user.email)
        patch password_reset_path(user.reset_token), :params => { :email => user.email,
                                                                  :user => {
                                                                    :password => "",
                                                                    :password_confirmation => ""
                                                                  } }
        expect(request.fullpath).to eq "/password_resets/#{user.reset_token}"
      end
    end

    context "token is expired" do
      it "fail to patch" do
        post password_resets_path, :params => { :password_reset => { :email => user.email } }
        user = assigns(:user)
        user.update_attribute(:reset_sent_at, 10.hours.ago)
        get edit_password_reset_path(user.reset_token, :email => user.email)
        patch password_reset_path(user.reset_token), :params => { :email => user.email,
                                                                  :user => {
                                                                    :password => "testuser",
                                                                    :password_confirmation => "testuser"
                                                                  } }
        expect(response).to redirect_to new_password_reset_url
      end
    end
  end
end
