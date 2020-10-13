require "rails_helper"

RSpec.describe "users", type: :system do

  describe "user create a new account" do
    context "submit valid values" do
      it "add users count" do
        expect {
        visit signup_path
        fill_in "name", with: "testuser"
        fill_in "email", with: "testuser@example.com"
        fill_in "password", with: "password"
        fill_in "password_confirmation", with: "password"
        click_button "Create Account"}.to change(User, :count).by(1)
        expect(current_path).to eq user_path(1)
      end
    end

    context "submit invalid values" do
      before do
        visit signup_path
        fill_in "name", with: ""
        fill_in "email", with: "testuser@invalid"
        fill_in "password", with: ""
        fill_in "password_confirmation", with: ""
        click_button "Create Account"
        expect(current_path).to eq signup_path
      end
      it "gets error messages" do
        expect(page).to have_selector("#error_explanation")
        expect(page).to have_selector(".alert-danger")
      end
    end
  end

end