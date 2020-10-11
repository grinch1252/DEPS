require "rails_helper"

RSpec.describe "Login", type: :system do

  let!(:user) { create(:user) }

  describe "login with invalid values" do
    it "reject login because submitted invalid values" do
      visit login_path
      expect(page).to have_selector ".input-container"
      fill_in "email", with: ""
      fill_in  "password", with: ""
      click_button "Login"
      expect(current_path).to eq login_path
      expect(page).to have_selector ".input-container"
      expect(page).to have_selector ".alert-danger"
    end
    it "delete error message" do
      visit login_path
      expect(page).to have_selector ".input-container"
      fill_in "email", with: ""
      fill_in "password", with: ""
      click_button "Login"
      expect(current_path).to eq login_path
      expect(page).to have_selector ".input-container"
      expect(page).to have_selector ".alert-danger"
      visit root_path
      expect(page).not_to have_selector ".alert-danger"
    end
  end

  # describe "login with valid values" do
  #   it "success login" do
  #     visit login_path
  #     expect(page).to have_selector ".input-container"
  #     fill_in "email", with: user.email
  #     fill_in "password", with: user.password
  #     click_button "Login"
  #     expect(current_path).to eq user_path(1)
  #     expect(response).to have_http_status 302
  #   end
  # end
end