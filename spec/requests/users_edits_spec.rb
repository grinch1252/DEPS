require "rails_helper"

RSpec.describe "UsersEdits", type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe "get edit_user_path" do
    context "valid edit" do
      it "subit valid values" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        valid_edit
        expect(flash[:success]).to be_truthy
        expect(response).to redirect_to user_path(user)
      end

      it "submit valid values before login" do
        get edit_user_path(user)
        valid_edit
        expect(response).to redirect_to login_path
        log_in_as(user)
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context "invalid edit" do
      it "submit invalid values" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        invalid_edit
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context "before login" do
      it "should redirect to login_path" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "as wrong user" do
      it "should redirect to root_path" do
        log_in_as(other_user)
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end

      it "should reject values from wrong user" do
        log_in_as(other_user)
        get edit_user_path(user)
        valid_edit
        expect(response).to redirect_to root_path
      end
    end
  end
end
