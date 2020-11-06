require "rails_helper"

RSpec.describe "users", type: :system do

  describe "#create user" do
    context "submit valid values" do
      it "add users count" do
        expect {
        visit signup_path
        fill_in "name", with: "testuser"
        fill_in "email-address", with: "testuser@example.com"
        fill_in "password", with: "password"
        fill_in "password confirmation", with: "password"
        click_button "Create Account"}.to change(User, :count).by(1)
        expect(current_path).to eq root_path
      end
    end

    context "submit invalid values" do
      before do
        visit signup_path
        fill_in "name", with: ""
        fill_in "email-address", with: "testuser@invalid"
        fill_in "password", with: ""
        fill_in "password confirmation", with: ""
        click_button "Create Account"
      end
      it "gets error messages" do
        expect(page).to have_selector(".alert-danger")
      end
    end
  end

end