require "rails_helper"

RSpec.describe "users", type: :system do

  describe "#create user" do
    context "submit valid values" do
      it "add users count" do
        expect {
        visit signup_path
        fill_in "名前", with: "testuser"
        fill_in "メールアドレス", with: "testuser@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード再確認", with: "password"
        click_button "アカウント作成"}.to change(User, :count).by(1)
        expect(current_path).to eq root_path
      end
    end

    context "submit invalid values" do
      before do
        visit signup_path
        fill_in "名前", with: ""
        fill_in "メールアドレス", with: "testuser@invalid"
        fill_in "パスワード", with: ""
        fill_in "パスワード再確認", with: ""
        click_button "アカウント作成"
      end
      it "gets error messages" do
        expect(page).to have_selector(".alert-danger")
      end
    end
  end

end