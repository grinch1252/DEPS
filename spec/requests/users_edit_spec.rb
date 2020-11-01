require "rails_helper"

RSpec.describe "UsersEdit", type: :request do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe "#edit user" do
    context "submit valid values" do
      it "succeed edit" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        valid_edit
        expect(flash[:success]).to be_truthy
        expect(response).to redirect_to user_path(user)
      end
    end

    context "submit invalid values" do
      it "fail to edit" do
        log_in_as(user)
        expect(is_logged_in?).to be_truthy
        get edit_user_path(user)
        invalid_edit
        expect(flash[:danger]).to be_truthy
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context "before login" do
      it "failt t edit" do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end

    context "as wrong user" do
      it "fail to edit" do
        log_in_as(other_user)
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end
  end
end
