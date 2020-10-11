require "rails_helper"

RSpec.describe "Users", type: :request do

  describe "get signup_path" do
    it "submit invalid values" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect {
        post signup_path, params: {
          user: {
            name: "",
            email: "example@in-va-lid.com..",
            password: "test",
            password_confirmation: "foo"
          }
        }
      }.not_to change(User, :count)
    end
    it "submit valid values" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect {
        post signup_path, params: {
          user: {
            name: "testuser",
            email: "example@valid.com",
            password: "testuser",
            password_confirmation: "testuser"
          }
        }
      }.to change(User, :count).by(1)
    end
  end
end
