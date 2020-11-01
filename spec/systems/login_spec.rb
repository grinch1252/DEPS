require "rails_helper"

RSpec.describe "Login", type: :system do
  
  let!(:user) { create(:user) }

  describe "login" do
    context "valid values" do
      it "success login" do
        visit login_path
        expect(page).to have_selector ".input-container"
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button "Login"
        expect(current_path).to eq user_path(user)
      end
    end

    context "invalid values" do
      it "fail to login" do
        visit login_path
        expect(page).to have_selector ".input-container"
        fill_in "email", with: ""
        fill_in  "password", with: ""
        click_button "Login"
        expect(current_path).to eq login_path
        expect(page).to have_selector ".input-container"
        expect(page).to have_selector ".alert-danger"
      end

      it "has error message" do
        visit login_path
        expect(page).to have_selector ".input-container"
        fill_in "email", with: ""
        fill_in "password", with: ""
        click_button "Login"
        expect(current_path).to eq login_path
        expect(page).to have_selector ".input-container"
        expect(page).to have_selector ".alert-danger"
        visit root_path
      end
    end
  end


  describe "logout" do
    it "succeed logout" do
      visit login_path
      expect(page).to have_selector ".input-container"
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Login"
      expect(current_path).to eq user_path(user)
      find(".header-toggle").click
      click_link "Logout"
      expect(current_path).to eq root_path
    end
  end
end