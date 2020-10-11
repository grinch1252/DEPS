require "rails_helper"

RSpec.describe "Sessions", type: :request do
  
  let!(:user) { create(:user) }

  describe "get login_path" do
    it "submit invalid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
    end
    it "submit valid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(flash[:danger]).to be_falsey
    end
  end
end
